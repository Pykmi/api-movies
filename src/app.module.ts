import { Module } from '@nestjs/common';

import { AppService } from './app.service';
import { StorageModule } from './storage/storage.module';
import { HealthController } from './health/health.controller';
import { MoviesController } from './controller/movies.controller';
import { MoviesService } from './controller/movies.service';
import { LoggingService } from './logging/logging.service';
import { loadConfig } from './config/environment';
import { ConfigModule } from '@nestjs/config';

const appConfig = loadConfig();

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      envFilePath: [`.env.${process.env.NODE_ENV}`, '.env'],
    }),
    StorageModule,
  ],
  controllers: [HealthController, MoviesController],
  providers: [
    AppService,
    MoviesService,
    {
      provide: 'APP_CONFIG',
      useValue: appConfig,
    },
    LoggingService,
  ],
  exports: [LoggingService, 'APP_CONFIG'],
})
export class AppModule {}
