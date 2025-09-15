import {
  Injectable,
  CanActivate,
  ExecutionContext,
  UnauthorizedException,
} from '@nestjs/common';
import { Request } from 'express';

@Injectable()
export class ApiKeyGuard implements CanActivate {
  private readonly apiKey = process.env.API_KEY;

  canActivate(context: ExecutionContext): boolean {
    const request = context.switchToHttp().getRequest<Request>();
    const key = request.headers['x-api-key'] as string;

    if (key && key === this.apiKey) {
      return true;
    }

    throw new UnauthorizedException('Invalid API key');
  }
}
