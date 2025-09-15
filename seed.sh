#!/bin/bash
set -e

# Load env vars from .env (fallback to .env.development if it exists)
if [ -f ".env.$NODE_ENV" ]; then
  export $(grep -v '^#' ".env.$NODE_ENV" | xargs)
elif [ -f ".env" ]; then
  export $(grep -v '^#' ".env" | xargs)
fi

DB_CONTAINER="movies-db"   # 👈 still needs to match your docker container name
DB_USER="${POSTGRES_USER}"
DB_NAME="${POSTGRES_NAME}"
SEED_FILE="migrations/0001_seeds.sql"

echo "🌱 Seeding database with $SEED_FILE..."

# Execute the seed file inside the Postgres container
docker exec -i $DB_CONTAINER \
  psql -U "$DB_USER" -d "$DB_NAME" -q -v ON_ERROR_STOP=1 < "$SEED_FILE"

echo "✅ Seed complete!"
