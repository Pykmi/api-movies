import { Controller, Get, UseGuards } from '@nestjs/common';
import {
  ApiOkResponse,
  ApiOperation,
  ApiSecurity,
  ApiServiceUnavailableResponse,
  ApiTags,
  ApiUnauthorizedResponse,
} from '@nestjs/swagger';

import { MovieWithRelations } from '../storage/storage.types';
import { MoviesService } from './movies.service';
import { ErrorResponse, MovieDto } from './movies.dto';
import { ApiKeyGuard } from 'src/auth/api-key.guard';

@ApiTags('movies')
@ApiSecurity('api-key')
@UseGuards(ApiKeyGuard)
@Controller('movies')
export class MoviesController {
  constructor(private readonly moviesService: MoviesService) {}

  @Get()
  @ApiOperation({
    summary: 'Get all movies',
    description: 'Returns all movies with director and actors',
  })
  @ApiOkResponse({ type: [MovieDto] })
  @ApiServiceUnavailableResponse({
    description: 'Database unavailable',
    type: ErrorResponse,
  })
  @ApiUnauthorizedResponse({
    description: 'Missing or invalid API key',
  })
  async findAll(): Promise<MovieWithRelations[]> {
    return this.moviesService.findAllWithRelations();
  }
}
