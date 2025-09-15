import { defineConfig } from 'drizzle-kit';
import * as dotenv from 'dotenv';
import { existsSync } from 'fs';

const environment = process.env.NODE_ENV ?? 'development';
const file = existsSync(`.env.${environment}`) ? `.env.${environment}` : '.env';

dotenv.config({ path: file });

export default defineConfig({
  dialect: 'postgresql',
  schema: './src/config/schema.ts',
  out: './migrations',
  dbCredentials: {
    host: process.env.POSTGRES_HOST ?? 'localhost',
    port: parseInt(process.env.POSTGRES_PORT ?? '5432', 10),
    user: process.env.POSTGRES_USER ?? 'movies',
    password: process.env.POSTGRES_PASSWORD ?? 'password',
    database: process.env.POSTGRES_NAME ?? 'moviesdb',
    ssl: process.env.POSTGRES_SSL === 'false',
  },
});
