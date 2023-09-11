import { Types, Document } from "mongoose"

export interface IRoom extends Document {
    user: Types.ObjectId
    number: string
    capacity: number
}