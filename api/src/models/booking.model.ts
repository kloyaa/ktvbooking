import { Schema, model } from 'mongoose'
import { IBooking } from '../interface/booking.interface'

const booking = new Schema<IBooking>({
  user: {
    type: Schema.Types.ObjectId,
    ref: 'User',
    required: true
  }, // Reference to the User model
  room: {
    type: Schema.Types.ObjectId,
    ref: 'Room',
    required: true
  },
  start: {
    type: Date,
    required: true
  },
  end: {
    type: Date,
    required: true
  },
  active: {
    type: Boolean,
    required: true,
    default: false
  }
}, { timestamps: true })

export const Booking = model<IBooking>('Booking', booking)
