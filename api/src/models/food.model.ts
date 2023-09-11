import { Schema, model } from 'mongoose'
import { type ITransaction } from '../interface/bet.interface'
import { IFood } from '../interface/food.interface'

const food = new Schema<IFood>({
  name: {
    type: String,
    required: true
  },
  price: {
    type: Number,
    required: true,
    default: 1
  },
}, { timestamps: true })

export const Food = model<IFood>('Food', food)
