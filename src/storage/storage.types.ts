import { InferSelectModel } from 'drizzle-orm';
import { movieActors, movies, people } from '../config/schema';

export type Movie = InferSelectModel<typeof movies>;

export type Person = InferSelectModel<typeof people>;

export type MovieActor = InferSelectModel<typeof movieActors>;

export type MovieActorWithPerson = {
  movieActor: MovieActor;
  person: Person;
};

export type MovieWithRelations = Movie & {
  director: Person | null;
  actors: Person[];
};
