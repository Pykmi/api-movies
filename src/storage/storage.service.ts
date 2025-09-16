import { Inject, Injectable } from '@nestjs/common';
import { NodePgDatabase } from 'drizzle-orm/node-postgres';
import { and, eq } from 'drizzle-orm';

import * as schema from '../config/schema';
import { movieActors, movies, people } from '../config/schema';
import { Movie, MovieActorWithPerson, Person } from './storage.types';

@Injectable()
export class StorageService {
  constructor(
    @Inject('STORAGE') private storage: NodePgDatabase<typeof schema>,
  ) {}

  findAllMovies(): Promise<Movie[]> {
    return this.storage.select().from(movies);
  }

  findPersonById(id: number): Promise<Person[]> {
    return this.storage.select().from(people).where(eq(people.id, id));
  }

  async findActorsByMovie(movieId: number): Promise<MovieActorWithPerson[]> {
    const rows = await this.storage
      .select()
      .from(movieActors)
      .innerJoin(people, eq(movieActors.personId, people.id))
      .where(eq(movieActors.movieId, movieId));

    return rows.map((row) => ({
      movieActor: row.movie_actors,
      person: row.people,
    }));
  }

  async findOrCreatePerson(
    firstName: string,
    lastName: string,
    type: 'ACTOR' | 'DIRECTOR',
  ): Promise<Person> {
    const [existing] = await this.storage
      .select()
      .from(people)
      .where(
        and(
          eq(people.firstName, firstName),
          eq(people.lastName, lastName),
          eq(people.type, type),
        ),
      );

    if (existing) return existing;

    const [inserted] = await this.storage
      .insert(people)
      .values({ firstName, lastName, type })
      .returning();

    return inserted;
  }

  async insertMovie(data: Omit<Movie, 'id'>): Promise<Movie> {
    const [inserted] = await this.storage
      .insert(movies)
      .values(data)
      .returning();
    return inserted;
  }

  async linkActorToMovie(movieId: number, personId: number): Promise<void> {
    await this.storage.insert(movieActors).values({ movieId, personId });
  }
}
