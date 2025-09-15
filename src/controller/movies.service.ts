import {
  Injectable,
  Logger,
  ServiceUnavailableException,
} from '@nestjs/common';

import { StorageService } from '../storage/storage.service';
import { MovieWithRelations } from '../storage/storage.types';

@Injectable()
export class MoviesService {
  private readonly logger = new Logger(MoviesService.name);

  constructor(private readonly storage: StorageService) {}

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
}
