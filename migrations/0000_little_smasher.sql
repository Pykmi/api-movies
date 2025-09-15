CREATE TYPE "public"."person_type" AS ENUM('ACTOR', 'DIRECTOR');--> statement-breakpoint
CREATE TABLE "movie_actors" (
	"id" serial PRIMARY KEY NOT NULL,
	"movie_id" integer NOT NULL,
	"person_id" integer NOT NULL,
	CONSTRAINT "movie_actors_movie_id_person_id_unique" UNIQUE("movie_id","person_id")
);
--> statement-breakpoint
CREATE TABLE "movies" (
	"id" serial PRIMARY KEY NOT NULL,
	"name" varchar(255) NOT NULL,
	"year" integer NOT NULL,
	"age_limit" integer NOT NULL,
	"rating" integer NOT NULL,
	"synopsis" text,
	"director_id" integer NOT NULL
);
--> statement-breakpoint
CREATE TABLE "people" (
	"id" serial PRIMARY KEY NOT NULL,
	"first_name" varchar(100) NOT NULL,
	"last_name" varchar(100) NOT NULL,
	"type" "person_type" NOT NULL,
	CONSTRAINT "people_name_type_unique" UNIQUE("first_name","last_name","type")
);
--> statement-breakpoint
ALTER TABLE "movie_actors" ADD CONSTRAINT "movie_actors_movie_id_movies_id_fk" FOREIGN KEY ("movie_id") REFERENCES "public"."movies"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "movie_actors" ADD CONSTRAINT "movie_actors_person_id_people_id_fk" FOREIGN KEY ("person_id") REFERENCES "public"."people"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "movies" ADD CONSTRAINT "movies_director_id_people_id_fk" FOREIGN KEY ("director_id") REFERENCES "public"."people"("id") ON DELETE restrict ON UPDATE no action;