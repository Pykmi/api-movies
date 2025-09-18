# Movies API

A simple NestJS application that manages movies, directors, and actors.  
This project is built with **NestJS**, **PostgreSQL (via Drizzle ORM)**, and **Jest** for testing.

The code is structured for clarity and maintainability so new developers can pick it up quickly.

## Features

- Create a movie with director and actors
- Search movies by name, director, or actors
- View movies with relations (actors, director)
- API documented with **Swagger** (`/api/docs` route)

## Project Structure

- auth/
- config/
- controller/
- health/
- logging/
- storage/
- test/

## Getting Started

### Prerequisites

- Node.js (>= 18)
- npm or yarn
- PostgreSQL (local or Docker)

## Project Setup

### 1. Install prerequisites

- [Node.js](https://nodejs.org/) (>= 18.x)
- [NestJS CLI](https://docs.nestjs.com/cli/overview)

```bash
npm install -g @nestjs/cli
```

- [Docker](https://www.docker.com/) (with Docker Compose)

### 2. Start PostgreSQL with Docker

We use Docker Compose to run Postgres locally.

```bash
docker-compose up -d
```

This will spin up a container with the correct database and credentials.

### 3. Run database migrations

Apply schema changes to your local database.

```bash
npm run db:migrate
```

### 4. Seed initial data

Populate the database with example movies, directors, and actors.

```bash
npm run db:seed
```

### 5. Start the application

- **Normal mode**:

```bash
npm run start
```

- **Watch mode** (auto-reload on file changes):

```bash
npm run start:dev
```

**Notes**:

- Steps 2–4 (`docker-compose up -d` → `npm run db:migrate` → `npm run db:seed`) only need to be done **once** when setting up your local environment.
- After that, you can just run `npm run start:dev` to get going.m install

## Environment Variables

This project uses environment variables defined in a `.env` file.  
A `.env.sample` file is included in the repository — copy or rename it to `.env` before running the app:

```bash
cp .env.sample .env
```

### Important variables

- **`API_KEY`** – required for authenticating API requests.  
  When running locally, you can use the value provided in `.env.sample`.

- **Database settings** (`POSTGRES_HOST`, `POSTGRES_PORT`, `POSTGRES_USER`, `POSTGRES_PASSWORD`, `POSTGRES_NAME`)  
  These are preconfigured for local development with Docker.

### Using the API Key

All requests to the API require the `x-api-key` header. For example:

```http
GET /movies
x-api-key: supersecret123
```

When testing with **Swagger UI** (http://localhost:3000/api/docs), you must:

1. Click the **Authorize** button at the top right.
2. Enter the same value from `API_KEY` in your `.env` file.
3. Authorize and run requests.

## API Endpoints

All requests must include the `x-api-key` header with the value from your `.env` file.  
For local development, the `.env.sample` file provides a working key.

### Health Check

```bash
curl -H "x-api-key: supersecret123" http://localhost:3000/health
```

### Get All Movies

```bash
curl -H "x-api-key: supersecret123" http://localhost:3000/movies/search
```

### Search Movies by Keyword

Leave the query parameter out to return all movies from the database.

```bash
curl -H "x-api-key: supersecret123" "http://localhost:3000/movies/search?query=spielberg"
```

### Create a New Movie

Use the `POST /movies` endpoint to add a new movie to the database.  
Example request with sample JSON body:

```bash
curl -X POST http://localhost:3000/movies \
  -H "Content-Type: application/json" \
  -H "x-api-key: supersecret123" \
  -d '{
    "name": "Inception",
    "ageLimit": 13,
    "rating": 5,
    "year": 2010,
    "synopsis": "A skilled thief is offered a chance to have his past crimes forgiven if he can implant an idea into someone\'s subconscious.",
    "director": {
      "firstName": "Christopher",
      "lastName": "Nolan"
    },
    "actors": [
      { "firstName": "Leonardo", "lastName": "DiCaprio" },
      { "firstName": "Joseph", "lastName": "Gordon-Levitt" },
      { "firstName": "Elliot", "lastName": "Page" }
    ]
  }'
```

## Possible Improvements

There are several ways this project could be improved in the future:

### 1. Search Performance

- Currently, search queries use simple `ILIKE` filters.
- For larger datasets, performance can be improved by using PostgreSQL’s **Trigram indexes** (`pg_trgm` extension) or **Full-Text Search (FTS)**.
- These approaches allow faster lookups and more flexible searching (word-based queries, fuzzy matching).

### 2. Cross-Platform Database Seeding

- At present, data seeding is done with a shell script.
- This works on Linux and macOS, but developers on Windows may have to seed the database manually.
- A future improvement would be to make database seeding cross-platform.

### 3. Continuous Integration & Testing

- Pull requests should be blocked from merging unless all **unit tests pass**.
- Similarly, deployment pipelines should fail fast if tests fail.
- This ensures code quality and avoids broken deployments.

### 4. Authentication

- The current service uses an API key for request authentication.
- This is sufficient if requests are only proxied through another trusted service.
- If the service is exposed directly to users, a more robust authentication mechanism should be implemented, such as **JWT tokens** or OAuth.
