import { Controller, Get } from '@nestjs/common';
import {
  ApiOkResponse,
  ApiOperation,
  ApiProperty,
  ApiTags,
} from '@nestjs/swagger';

export class HealthResponse {
  @ApiProperty({ example: 'OK', description: 'Health status of the service' })
  status: string;
}

@ApiTags('health')
@Controller('health')
export class HealthController {
  @Get()
  @ApiOperation({
    summary: 'Health check',
    description: 'Returns OK if the service is up',
  })
  @ApiOkResponse({
    description: 'Service is healthy',
    type: HealthResponse,
  })
  health() {
    return { status: 'OK' };
  }
}
