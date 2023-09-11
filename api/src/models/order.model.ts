import { Schema, model } from 'mongoose'
import { type ITransaction } from '../interface/bet.interface'
import { IFood, IOrder } from '../interface/food.interface'

const order = new Schema<IOrder>({
    food: {
        type: Schema.Types.ObjectId,
        ref: 'Food',
        required: true
    }, 
    room: {
        type: Schema.Types.ObjectId,
        ref: 'Room',
        required: true
    }, // Reference to the User model
    qty: {
        type: Number,
        required: true,
        default: 1
    },
    message: {
        type: String,
        required: true
    },
    delivered: {
        type: Boolean,
        required: true,
        default: false
    }
}, { timestamps: true })

export const Order = model<IOrder>('Order', order)
