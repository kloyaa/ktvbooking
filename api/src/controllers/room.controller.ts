import { type Request, type Response } from 'express'
import { statuses } from '../../__core/const/api-statuses.const'
import { IRoom } from '../interface/room.interface'
import { Room } from '../models/room.model'
import { RequestValidator } from '../../__core/utils/validation.util'
import { ActivityType, EventName } from '../../__core/enum/activity.enum'
import { IActivity } from '../../__core/interfaces/schema.interface'
import { emitter } from '../../__core/events/activity.event'
import { PipelineStage } from 'mongoose'

export const create = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        // Check if there are any validation errors
        const error = new RequestValidator().createRoomAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }
        
        const room = await Room.findOne({ number: req.body.number })
        if(room) {
            return res.status(201).json(statuses['01'])
        }

        // Create a new Room document and associate it with the user
        const newRoom: IRoom = new Room({
            user: req.user.value,
            number: req.body.number
        })

        // Save the new Profile document to the database
        await newRoom.save()

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.ROOM_CREATED
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@create error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const getAll = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        const pipeline: PipelineStage[]  = [
            {
                $lookup: {
                    from: 'bookings',
                    localField: '_id',
                    foreignField: 'room',
                    as: 'booking'
                }
            },
            {
                $lookup: {
                    from: 'orders',
                    localField: '_id',
                    foreignField: 'room',
                    as: 'order'
                }
            },
            {
                $project: {
                    number: 1,
                    order: {
                        $filter: {
                            input: '$order',
                            as: 'orderItem',
                            cond: { 
                                $eq: ['$$orderItem.delivered', false] // Should only get delivered:false objects
                            }
                        }
                    },
                    booking: {
                        $filter: {
                            input: '$booking',
                            as: 'bookingItem',
                            cond: { 
                                $eq: ['$$bookingItem.active', true] // Should only get active:true objects
                            }
                        }
                    },
                    createdAt: 1
                },
            },
            { $sort: { createdAt: -1 } }
        ]
        const result = await Room.aggregate(pipeline)
        return res.status(200).json(result)
    } catch (error) {
        console.log('@getAll error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}