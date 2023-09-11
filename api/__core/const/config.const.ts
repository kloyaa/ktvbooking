require('dotenv').config()
import { EnvVariables } from "../interfaces/env";

export const envVars: EnvVariables = {
    ENVIRONMENT: process.env.ENVIRONMENT,
    ENVIRONMENT_MAINTENANCE: process.env.ENVIRONMENT_MAINTENANCE,
    PORT: process.env.PORT,
    DB_CONNECTION_STRING: process.env.DB_CONNECTION_STRING,
    DB_CONNECTION_STRING_LOCAL: process.env.DB_CONNECTION_STRING_LOCAL,
    AWS_ACCESS_KEY_ID: process.env.AWS_ACCESS_KEY_ID,
    AWS_SECRET_ACCESS_KEY: process.env.AWS_SECRET_ACCESS_KEY,
    AWS_SECRET_NAME: process.env.AWS_SECRET_NAME,
    BET_DOUBLE_NUM_LIMIT: process.env.BET_DOUBLE_NUM_LIMIT,
    BET_TRIPLE_NUM_LIMIT: process.env.BET_TRIPLE_NUM_LIMIT,
    BET_NORMAL_NUM_LIMIT: process.env.BET_NORMAL_NUM_LIMIT,
    BET_RAMBLE_NUM_LIMIT: process.env.BET_RAMBLE_NUM_LIMIT,
    JWT_SECRET: process.env.JWT_SECRET,
    HASH_KEY: process.env.HASH_KEY
}