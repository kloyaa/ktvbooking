import { Router } from 'express'
import { create, createMany, updateDeliveryStatus, deleteOrder } from '../controllers/order.controller'
import { isAuthenticated } from '../../__core/middlewares/jwt.middleware'
const router = Router()

router.post('/order/v1',
  isAuthenticated,
  create
)

router.post('/order/v1/place-many',
  isAuthenticated,
  createMany
)

router.put('/order/v1',
  isAuthenticated,
  updateDeliveryStatus
)

router.delete('/order/v1',
  isAuthenticated,
  deleteOrder
)

export default router
