# Landmark Hotel Reservation System

This repository contains my MIT 8103 Advanced Database Systems portfolio. I used a fictional Landmark Hotel scenario so that I could design and test a realistic reservation database without using real guest or payment information.

The portfolio starts with a PostgreSQL design, then builds on it with query optimisation, transaction and concurrency work, a small MongoDB use case, and a proposed distributed/cloud design.

## What the system covers

The relational model covers guests, room types, rooms, bookings, room assignments and payments. A booking can include more than one room assignment. PostgreSQL is used for the core reservation data because the booking and payment processes need relationships, constraints and transactions. Portfolio 4 uses MongoDB only for flexible guest-preference data.

## Portfolio folders

- `portfolio-1-database-design/` — case study, ER diagram, PostgreSQL schema, sample data, validation queries and normalisation notes.
- `portfolio-2-query-optimisation/` — business queries, an isolated benchmark, execution plans and performance analysis.
- `portfolio-3-transactions-concurrency/` — commit/rollback and double-booking prevention tests.
- `portfolio-4-nosql/` — MongoDB guest-profile model and query scripts.
- `portfolio-5-distributed-cloud/` — proposed distributed/cloud architecture and its trade-offs.

## Running Portfolio 1

I recommend PostgreSQL 14 or later and either pgAdmin or `psql`.

1. Create a database called `landmark_hotel_db`.
2. Run `portfolio-1-database-design/John_Ayinde_301915931_Schema.sql`.
3. Run `portfolio-1-database-design/John_Ayinde_301915931_SampleData.sql`.
4. Run `portfolio-1-database-design/John_Ayinde_301915931_ConstraintTests.sql` and review the output.

```bash
createdb landmark_hotel_db
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_Schema.sql
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_SampleData.sql
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_ConstraintTests.sql
```

The ER diagram source is `portfolio-1-database-design/John_Ayinde_301915931_ERDiagram.mmd`. The basic schema handles keys and data checks. The PostgreSQL exclusion constraint that prevents overlapping active stays is introduced separately in Portfolio 3, where I demonstrate the concurrency rule.

All screenshots in this portfolio should come from my own test runs. The repository contains fictional data only.
