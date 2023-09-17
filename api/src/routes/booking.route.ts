import { Router } from 'express'
import { create, updateBookingStatus, deleteBooking, getAllBookingRequests, getMyBookings } from '../controllers/booking.controller'
import { isAuthenticated } from '../../__core/middlewares/jwt.middleware'
const router = Router()

router.post('/booking/v1',
  isAuthenticated,
  create
)

router.get('/booking/v1',
  isAuthenticated,
  getAllBookingRequests
)

router.get('/booking/v1/me',
  isAuthenticated,
  getMyBookings
)

router.put('/booking/v1',
  isAuthenticated,
  updateBookingStatus
)

router.put('/booking/v1',
  isAuthenticated,
  updateBookingStatus
)

router.delete('/booking/v1',
  isAuthenticated,
  deleteBooking
)

export default router
