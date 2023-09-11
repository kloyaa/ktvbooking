import { type Request, type Response } from 'express'
import { RequestValidator } from '../../__core/utils/validation.util'
import { statuses } from '../../__core/const/api-statuses.const'
import { emitter } from '../../__core/events/activity.event'
import { ActivityType, EventName } from '../../__core/enum/activity.enum'
import { IActivity } from '../../__core/interfaces/schema.interface'
import { IFood } from '../interface/food.interface'
import { Food } from '../models/food.model'
import { isValidObjectId } from 'mongoose'

export const create = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        const error = new RequestValidator().createFoodAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }
        
        const newFood: IFood = new Food({
            name: req.body.name,
            price: req.body.price,
        })

        await newFood.save()

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.FOOD_CREATED
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@create error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const getAll  = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    const result = await Food.find();
    return res.status(200).json(result);
}

export const remove = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        if(!isValidObjectId(req.params._id)) {
            return res.status(400).json({
                ...statuses['500'],
                message: "Invalid format."
            })
        }
        
        const result = await Food.findByIdAndDelete(req.params._id);
        if(!result) {
            return res.status(400).json(statuses['02'])
        }

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.FOOD_DELETED
        } as IActivity);

        return res.status(400).json(statuses['00'])
    } catch (error) {
        console.log('@remove error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

