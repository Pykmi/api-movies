import { Inject, Injectable, Logger, LoggerService } from '@nestjs/common';
import type { AppConfig } from '../config/environment';
import { Environment } from '../config/environment';

@Injectable()
export class LoggingService implements LoggerService {
  private readonly logger = new Logger('App');

  constructor(@Inject('APP_CONFIG') private readonly config: AppConfig) {}

  log(message: string, context?: string) {
    this.logger.log(message, context);
  }

  warn(message: string, context?: string) {
    this.logger.warn(message, context);
  }

  error(message: string, trace?: string, context?: string) {
    this.logger.error(message, this.isDev() ? trace : undefined, context);
  }

  debug(message: string, context?: string) {
    if (this.isDev()) {
      this.logger.debug(message, context);
    }
  }

  verbose(message: string, context?: string) {
    if (this.isDev()) {
      this.logger.verbose(message, context);
    }
  }

  private isDev() {
    return this.config.env === Environment.Development;
  }
}
