import { Router } from 'express'
import { create, getAll } from '../controllers/room.controller'
import { isAuthenticated } from '../../__core/middlewares/jwt.middleware'
const router = Router()

router.post('/room/v1',
  isAuthenticated,
  create
)

router.get('/room/v1',
  isAuthenticated,
  getAll
)

export default router
