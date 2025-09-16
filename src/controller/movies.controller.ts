import { Body, Controller, Get, Post, Query, UseGuards } from '@nestjs/common';
import {
  ApiBadRequestResponse,
  ApiCreatedResponse,
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
import { CreateMovieDto } from './create-movie.dto';

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

  @Post()
  @ApiOperation({
    summary: 'Create a new movie',
    description: 'Adds a new movie with director and actors',
  })
  @ApiCreatedResponse({
    description: 'Movie successfully created',
    type: MovieDto,
  })
  @ApiBadRequestResponse({
    description: 'Validation failed',
    type: ErrorResponse,
  })
  @ApiUnauthorizedResponse({
    description: 'Missing or invalid API key',
  })
  async create(@Body() dto: CreateMovieDto): Promise<MovieWithRelations> {
    return this.moviesService.create(dto);
  }

  @Get('search')
  @ApiOperation({
    summary: 'Get all movies or search',
    description:
      'Returns all movies with director and actors. If `search` query param is provided, performs a keyword search.',
  })
  @ApiOkResponse({ type: [MovieDto] })
  async search(@Query('q') q: string): Promise<MovieWithRelations[]> {
    if (q) {
      return this.moviesService.searchWithRelations(q);
    }
    return this.moviesService.findAllWithRelations();
  }
}
