import { Inject, Injectable, Logger, LoggerService } from '@nestjs/common';
import type { AppConfig } from '../config/environment';
import { isDev } from '../config/environment';

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
    this.logger.error(
      message,
      isDev(this.config.env) ? trace : undefined,
      context,
    );
  }

  debug(message: string, context?: string) {
    if (isDev(this.config.env)) {
      this.logger.debug(message, context);
    }
  }

  verbose(message: string, context?: string) {
    if (isDev(this.config.env)) {
      this.logger.verbose(message, context);
    }
  }
}
