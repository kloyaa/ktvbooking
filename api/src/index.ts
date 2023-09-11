import express, { type Application } from 'express'
import cors from 'cors'
import helmet from 'helmet'
import connectDB from '../__core/utils/db.util'
import authRoute from './routes/auth.route'
import profileRoute from './routes/profile.route'
import betRoute from './routes/bet.route'
import employeeRoute from './routes/employee.route'
import acitvityRoute from './routes/activity.route'
import configRoute from './routes/config.route'
import transactionRoute from './routes/transaction.route'
import roomRoute from './routes/room.route'
import bookingRoute from './routes/booking.route'
import foodRoute from './routes/food.route'
import orderRoute from './routes/order.route'

import { maintenanceModeMiddleware } from '../__core/middlewares/is-maintenance-mode.middleware'
import { envVars } from '../__core/const/config.const'

const app: Application = express()

async function runApp () {
  const port = Number(envVars.PORT) || 5000;
  // Middleware
  app.use(helmet()) // Apply standard security headers
  app.use(cors()) // Enable CORS for all routes
  app.use(express.json())

  // Routes
  app.use(maintenanceModeMiddleware)
  app.use('/api', authRoute)
  app.use('/api', profileRoute)
  app.use('/api', betRoute)
  app.use('/api', employeeRoute)
  app.use('/api', acitvityRoute)
  app.use('/api', configRoute)
  app.use('/api', transactionRoute)
  app.use('/api', roomRoute)
  app.use('/api', bookingRoute)
  app.use('/api', foodRoute)
  app.use('/api', orderRoute)

  // Connect to MongoDB
  connectDB()

  // Start the HTTPS server
  app.listen(port, () => {
    console.log({
      Environment: envVars.ENVIRONMENT,
      Port: port,
    });
  });
}

runApp()

export default app
