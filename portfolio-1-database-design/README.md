# Portfolio 1 - Database Design and Modelling

## Files

- `case-study.md`: organisation, users, data and operations.
- `erd.mmd`: editable Mermaid ER diagram source.
- `schema.sql`: PostgreSQL tables, primary keys, foreign keys, checks and indexes.
- `seed.sql`: fictional sample records.
- `validation_queries.sql`: queries to confirm that the model works.
- `normalisation.md`: 1NF, 2NF and 3NF explanation.

## Implementation steps

1. Create a PostgreSQL database named `landmark_hotel_db`.
2. Run `schema.sql`.
3. Run `seed.sql`.
4. Run each query in `validation_queries.sql` and check the result.
5. Capture screenshots of the SQL execution and results in a local `evidence/` folder.
6. Update this README with your PostgreSQL version, the date you tested the scripts, any changes you made, and a short explanation of what you observed.

## Evidence to capture

- ER diagram rendered from `erd.mmd`.
- Successful table creation in pgAdmin or `psql`.
- Table structure showing primary and foreign keys.
- Sample rows from guests, rooms, bookings, booking_rooms and payments.
