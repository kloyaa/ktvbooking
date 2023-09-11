import { type Request, type Response } from 'express'
import { RequestValidator } from '../../__core/utils/validation.util'
import { statuses } from '../../__core/const/api-statuses.const'
import { Booking } from '../models/booking.model'
import { IBooking } from '../interface/booking.interface'
import { emitter } from '../../__core/events/activity.event'
import { ActivityType, EventName } from '../../__core/enum/activity.enum'
import { IActivity } from '../../__core/interfaces/schema.interface'
import { ObjectId } from 'mongodb'
import { Room } from '../models/room.model'
import { PipelineStage } from 'mongoose'

export const create = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        // Check if there are any validation errors
        const error = new RequestValidator().createBookingAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }
        
        const room = await Room.findById(new ObjectId(req.body.room))
        if(!room) {
            return res.status(400).json(statuses['01'])
        }

        // Create a new Room document and associate it with the user
        const newBooking: IBooking = new Booking({
            user: req.user.value,
            room: req.body.room,
            start: req.body.start,
            end: req.body.end
        })

        // Save the new Profile document to the database
        await newBooking.save()

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.ROOM_BOOKING_CREATED
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@create error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const getAllBookingRequests = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> =>  {
    try {
        const pipeline: PipelineStage[]  = [
            {
                $match: {
                    active: false
                }
            },
            {
                $lookup: {
                    from: 'users',
                    localField: 'user',
                    foreignField: '_id',
                    as: 'user'
                }
            },
            {
                $lookup: {
                    from: 'rooms',
                    localField: 'room',
                    foreignField: '_id',
                    as: 'room'
                }
            },
            { $unwind: '$user' },
            { $unwind: '$room' },
            {
                $project: {
                    _id: 0,
                    user: {
                        _id: 1,
                        username: 1,
                        email: 1,
                    },
                    createdAt: 1,
                    room: {
                        _id: 1,
                        number: 1
                    }
                },
            },
            { $sort: { createdAt: -1 } }
        ]
        const result = await Booking.aggregate(pipeline)
        return res.status(200).json(result);
    } catch (error) {
        console.log('@getAll error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const updateBookingStatus = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {
        const error = new RequestValidator().updateBookingAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }

        const order = await Booking.findOneAndUpdate({
            user: req.body.user,
            room: req.body.room,
        }, { active: req.body.active }).exec();

        if(!order) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Booking not found."
            })
        }

        if(req.body.active) {
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.value,
                description: ActivityType.ROOM_APPROVE_BOOKING_STATUS
            } as IActivity)
        } else {
            emitter.emit(EventName.ACTIVITY, {
                user: req.user.value,
                description: ActivityType.ROOM_COMPLETE_BOOKING_STATUS
            } as IActivity)
        }

       

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@updateBookingStatus error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}

export const deleteBooking = async (req: Request & { user?: any }, res: Response): Promise<Response<any>> => {
    try {

        const error = new RequestValidator().updateBookingAPI(req.body)
        if (error) {
            return res.status(400).json({
                ...statuses['501'],
                error: error.details[0].message.replace(/['"]/g, '')
            })
        }

        const booking = await Booking.findOneAndDelete({
            user: req.body.user,
            room: req.body.room,
        }).exec();

        if(!booking) {
            return res.status(400).json({
                ...statuses['02'],
                message: "Booking not found."
            })
        }

        emitter.emit(EventName.ACTIVITY, {
            user: req.user.value,
            description: ActivityType.ROOM_CANCEL_BOOKING_STATUS
        } as IActivity)

        return res.status(201).json(statuses['00'])
    } catch (error) {
        console.log('@deleteBooking error', error)
        return res.status(500).json({ ...statuses['0900'], error })
    }
}