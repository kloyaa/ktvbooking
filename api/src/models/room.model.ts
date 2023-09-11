import { Schema, model } from 'mongoose'
import { type ITransaction } from '../interface/bet.interface'
import { IRoom } from '../interface/room.interface'

const room = new Schema<IRoom>({
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  }, // Reference to the User model
  number: {
    type: String,
    required: true
  },
  capacity: {
    type: Number,
    default: 2
  }
}, { timestamps: true })

export const Room = model<IRoom>('Room', room)
