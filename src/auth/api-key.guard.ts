import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
  Inject,
} from '@nestjs/common';
import { Request } from 'express';
import type { AppConfig } from 'src/config/environment';

@Injectable()
export class ApiKeyGuard implements CanActivate {
  constructor(@Inject('APP_CONFIG') private readonly config: AppConfig) {}

  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<Request>();
    const key = request.headers['x-api-key'] as string;

    if (key && key === this.config.apikey) {
      return true;
    }

    throw new UnauthorizedException('Invalid API key');
  }
}
