import { Router } from 'express'
import { create, remove, getAll } from '../controllers/food.controller'
import { isAuthenticated } from '../../__core/middlewares/jwt.middleware'
const router = Router()

router.post('/food/v1',
  isAuthenticated,
  create
)

router.get('/food/v1',
  isAuthenticated,
  getAll
)

router.delete('/food/v1/:_id',
  isAuthenticated,
  remove
)
export default router
