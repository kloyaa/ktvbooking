import { Types, Document } from "mongoose"

export interface IBooking extends Document {
    user: Types.ObjectId
    room: Types.ObjectId
    start: Date
    end: Date
    active: boolean
}