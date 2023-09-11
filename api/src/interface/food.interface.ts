import { Types, Document } from "mongoose"

export interface IFood extends Document {
    name: string
    price: number
}

export interface IOrder extends Document {
    food: Types.ObjectId
    room: Types.ObjectId
    qty: number
    message: string
    delivered: boolean
}
