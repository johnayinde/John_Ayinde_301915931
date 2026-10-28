# Landmark Hotel Reservation System - MIT 8103 Portfolio

This repository is an academic project for MIT 8103 Advanced Database Systems. It uses a simulated Landmark Hotel reservation scenario and fictional sample records. Do not add real guest or payment information.

## Project scope

The system models guests, room types, rooms, bookings, room assignments and payments. One booking can include multiple room assignments. The relational implementation uses PostgreSQL. A MongoDB model can be added for Portfolio 4.

## Repository structure

- `portfolio-1-database-design/` - case study, ER diagram, schema, sample data, validation queries and normalisation notes.
- `portfolio-2-query-optimisation/` - add this folder when starting Portfolio 2.
- `portfolio-3-transactions-concurrency/` - add this folder when starting Portfolio 3.
- `portfolio-4-nosql/` - add this folder when starting Portfolio 4.
- `portfolio-5-distributed-cloud/` - add this folder when starting Portfolio 5.

## Requirements

- PostgreSQL 14 or later recommended.
- pgAdmin or `psql` to run the SQL scripts.

## Run Portfolio 1

1. Create a database named `landmark_hotel_db` in pgAdmin or with `createdb landmark_hotel_db`.
2. Run `portfolio-1-database-design/John_Ayinde_301915931_P1_Schema.sql` against that database.
3. Run `portfolio-1-database-design/John_Ayinde_301915931_P1_SampleData.sql`.
4. Run `portfolio-1-database-design/John_Ayinde_301915931_P1_ConstraintTests.sql` and inspect the results.
5. Save your own screenshots of successful execution and results in an `evidence/` folder. Only add screenshots after you have actually run the scripts.

Command-line example:

```bash
createdb landmark_hotel_db
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_P1_Schema.sql
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_P1_SampleData.sql
psql -d landmark_hotel_db -f portfolio-1-database-design/John_Ayinde_301915931_P1_ConstraintTests.sql
```

If your PostgreSQL installation uses a username or port different from the defaults, add the appropriate `psql` connection options.

## Important notes

- The ER diagram source is `portfolio-1-database-design/John_Ayinde_301915931_P1_ERDiagram.mmd` (Mermaid ER diagram). You can render it in a Mermaid-compatible editor or GitHub Markdown.
- The schema intentionally uses explicit foreign keys and check constraints.
- The base schema checks data integrity but does not yet include the advanced PostgreSQL exclusion constraint for preventing overlapping room reservations. That is a good practical extension for Portfolio 3, where you will demonstrate transaction and concurrency controls.
- Keep commits progressive and explain the work in your own words. Review and test every script before submission.
