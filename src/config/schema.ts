import {
  integer,
  pgEnum,
  pgTable,
  serial,
  text,
  unique,
  varchar,
} from 'drizzle-orm/pg-core';

export const personType = pgEnum('person_type', ['ACTOR', 'DIRECTOR']);

export const people = pgTable(
  'people',
  {
    id: serial('id').primaryKey(),
    firstName: varchar('first_name', { length: 100 }).notNull(),
    lastName: varchar('last_name', { length: 100 }).notNull(),
    type: personType('type').notNull(),
  },
  (table) => [
    unique('people_name_type_unique').on(
      table.firstName,
      table.lastName,
      table.type,
    ),
  ],
);

export const movies = pgTable('movies', {
  id: serial('id').primaryKey(),
  name: varchar('name', { length: 255 }).notNull(),
  year: integer('year').notNull(),
  ageLimit: integer('age_limit').notNull(),
  rating: integer('rating').notNull(),
  synopsis: text('synopsis'),
  directorId: integer('director_id')
    .notNull()
    .references(() => people.id, { onDelete: 'restrict' }),
});

export const movieActors = pgTable(
  'movie_actors',
  {
    id: serial('id').primaryKey(),
    movieId: integer('movie_id')
      .notNull()
      .references(() => movies.id, { onDelete: 'cascade' }),
    personId: integer('person_id')
      .notNull()
      .references(() => people.id, { onDelete: 'cascade' }),
  },
  (table) => [unique().on(table.movieId, table.personId)],
);
