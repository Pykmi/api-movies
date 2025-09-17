import { Inject, Injectable } from '@nestjs/common';
import { NodePgDatabase } from 'drizzle-orm/node-postgres';
import { and, eq, ilike, or } from 'drizzle-orm';

import * as schema from '../config/schema';
import { movieActors, movies, people } from '../config/schema';
import { Movie, MovieActorWithPerson, Person } from './storage.types';
import { alias } from 'drizzle-orm/pg-core';

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

  async search(keyword: string): Promise<Movie[]> {
    const pattern = `%${keyword}%`;

    const director = alias(people, 'd');
    const actor = alias(people, 'a');

    const rows = await this.storage
      .selectDistinct({ movie: movies })
      .from(movies)
      .leftJoin(director, eq(movies.directorId, director.id))
      .leftJoin(movieActors, eq(movies.id, movieActors.movieId))
      .leftJoin(actor, eq(movieActors.personId, actor.id))
      .where(
        or(
          ilike(movies.name, pattern),
          ilike(director.firstName, pattern),
          ilike(director.lastName, pattern),
          ilike(actor.firstName, pattern),
          ilike(actor.lastName, pattern),
        ),
      );

    return rows.map((row) => row.movie);
  }
}
