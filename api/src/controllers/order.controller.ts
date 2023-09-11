import { type Request, type Response } from 'express'
import { RequestValidator } from '../../__core/utils/validation.util'
import { statuses } from '../../__core/const/api-statuses.const'
import { emitter } from '../../__core/events/activity.event'
import { ActivityType, EventName } from '../../__core/enum/activity.enum'
import { IActivity } from '../../__core/interfaces/schema.interface'
import { IOrder } from '../interface/food.interface'
import { Food } from '../models/food.model'
import { Order } from '../models/order.model'
import { Room } from '../models/room.model'
import { isValidObjectId } from 'mongoose'

export const create = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        const error = new RequestValidator().createOrderAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }
        
        if(!isValidObjectId(req.body.food) || !isValidObjectId(req.body.room)) {
            return res.status(400).json({
                ...statuses['500'],
                message: "Invalid format."
            })
        }

        const [food, room] = await Promise.all([
            Food.findById(req.body.food).exec(),
            Room.findById(req.body.room).exec()
        ]);

        if(!food) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Food not found."
            })
        }

        if(!room) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Room not found."
            })
        }

        const newOrder: IOrder = new Order({
            food: req.body.food,
            room: req.body.room,
            qty: req.body.qty,
            message: req.body.message
        })

        await newOrder.save()

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.FOOD_ORDER_REATED
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@create error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const updateDeliveryStatus = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {

        const error = new RequestValidator().updateOrderAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }

        const order = await Order.findOneAndUpdate({
            room: req.body.room,
            food: req.body.food,
            delivered: false 
        }, { delivered: true }).exec();

        if(!order) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Order not found."
            })
        }

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.FOOD_COMPLETE_ORDER_STATUS
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@updateDeliveryStatus error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const deleteOrder = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {

        const error = new RequestValidator().updateOrderAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }

        const order = await Order.findOneAndDelete({
            food: req.body.food,
            room: req.body.room,
        }).exec();

        console.log(order)
        if(!order) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Order not found."
            })
        }

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.FOOD_CANCEL_ORDER_STATUS
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@deleteBooking error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}