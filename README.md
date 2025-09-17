# Movies API

A simple NestJS application that manages movies, directors, and actors.  
This project is built with **NestJS**, **PostgreSQL (via Drizzle ORM)**, and **Jest** for testing.

The code is structured for clarity and maintainability so new developers can pick it up quickly.

## Features

- Create a movie with director and actors
- Search movies by name, director, or actors
- View movies with relations (actors, director)
- API documented with **Swagger** (`/api` route)
- Unit tests for all core layers (controllers, services, storage)
- Ready for CI/CD pipelines (fast unit tests, optional e2e)

## Project Structure

- src/
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
