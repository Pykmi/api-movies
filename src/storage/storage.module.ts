import { Module } from '@nestjs/common';
import { drizzle, NodePgDatabase } from 'drizzle-orm/node-postgres';
import { Pool } from 'pg';
import * as schema from '../config/schema';
import { StorageService } from './storage.service';

const pool = new Pool({
  host: 'localhost',
  port: 5432,
  user: 'movies',
  password: 'Z8HxwzkPdZ26',
  database: 'moviesdb',
});

const storage: NodePgDatabase<typeof schema> = drizzle(pool, { schema });

@Module({
  providers: [
    {
      provide: 'STORAGE',
      useValue: storage,
    },
    StorageService,
  ],
  exports: ['STORAGE', StorageService],
})
export class StorageModule {}
