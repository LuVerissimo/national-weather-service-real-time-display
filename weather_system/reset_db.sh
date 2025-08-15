#!/bin/bash

# Stop on any error
set -e

DB_NAME="weather_system_dev"
DB_USER="weather_system"
PGPASSWORD="weather_system"

echo "Dropping database..."
mix ecto.drop --quiet

echo "Creating database..."
mix ecto.create --quiet

echo "Creating EventStore schema..."
psql -h localhost -U weather_system -P weather_system -d weather_system_dev -c "CREATE SCHEMA IF NOT EXISTS eventstore;"

echo "Initializing EventStore..."
mix event_store.init

echo "Running Ecto migrations..."
mix ecto.migrate

echo "✅ Database and EventStore setup complete!"
