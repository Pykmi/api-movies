import {
  Injectable,
  Logger,
  ServiceUnavailableException,
} from '@nestjs/common';

import { StorageService } from '../storage/storage.service';
import { MovieWithRelations, Person } from '../storage/storage.types';
import { CreateMovieDto } from './create-movie.dto';

@Injectable()
export class MoviesService {
  private readonly logger = new Logger(MoviesService.name);

  constructor(private readonly storage: StorageService) {}

  async create(dto: CreateMovieDto): Promise<MovieWithRelations> {
    try {
      const director = await this.storage.findOrCreatePerson(
        dto.director.firstName,
        dto.director.lastName,
        'DIRECTOR',
      );

      const movie = await this.storage.insertMovie({
        name: dto.name,
        year: dto.year,
        ageLimit: dto.ageLimit,
        rating: dto.rating,
        synopsis: dto.synopsis ?? null,
        directorId: director.id,
      });

      const actors: Person[] = [];
      for (const actor of dto.actors) {
        const person = await this.storage.findOrCreatePerson(
          actor.firstName,
          actor.lastName,
          'ACTOR',
        );
        actors.push(person);
        await this.storage.linkActorToMovie(movie.id, person.id);
      }

      return {
        ...movie,
        director,
        actors,
      };
    } catch (err) {
      const error = err as Error;
      this.logger.error('Failed to create movie', error.stack);
      throw new ServiceUnavailableException('Failed to create movie');
    }
  }

  async findAllWithRelations(): Promise<MovieWithRelations[]> {
    try {
      const movies = await this.storage.findAllMovies();

      return Promise.all(
        movies.map(async (m) => {
          const [director] = await this.storage.findPersonById(m.directorId);
          const actorRows = await this.storage.findActorsByMovie(m.id);

          return {
            ...m,
            director: director ?? null,
            actors: actorRows.map((a) => a.person),
          };
        }),
      );
    } catch (err) {
      const error = err as Error;

      this.logger.error(
        'Database query failed',
        error.stack,
        MoviesService.name,
      );

      throw new ServiceUnavailableException('Service is unavailable');
    }
  }

  async searchWithRelations(keyword: string): Promise<MovieWithRelations[]> {
    try {
      const movies = await this.storage.search(keyword);

      return Promise.all(
        movies.map(async (m) => {
          const [director] = await this.storage.findPersonById(m.directorId);
          const actorRows = await this.storage.findActorsByMovie(m.id);

          return {
            ...m,
            director: director ?? null,
            actors: actorRows.map((a) => a.person),
          };
        }),
      );
    } catch (err) {
      const error = err as Error;
      this.logger.error('Database search failed', error.stack);
      throw new ServiceUnavailableException('Service is unavailable');
    }
  }
}
