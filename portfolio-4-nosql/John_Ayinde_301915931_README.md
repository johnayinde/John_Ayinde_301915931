# Portfolio 4: NoSQL and Advanced Data Models

This portfolio adds a MongoDB document model for flexible guest preferences in the Landmark Hotel scenario. It complements the PostgreSQL reservation database; it does not replace it.

## Why I chose this data for MongoDB

Guest preferences can be optional and change over time. Examples include a preferred room type, bed type, accessibility needs, dietary preferences and notification choices. Keeping those fields in one document makes them easy to retrieve together while leaving booking and payment rules in PostgreSQL.

## What is needed

- MongoDB Community Server with `mongosh`, or a MongoDB Atlas deployment.
- A test database only. The scripts contain fictional data and must not be used for real guest or payment information.

## Run order

1. Start MongoDB or connect with `mongosh`.
2. Run `mongosh < John_Ayinde_301915931_MongoSetup.js` from this folder, or paste the script into a connected shell.
3. Run `John_Ayinde_301915931_MongoQueries.js` in the same database context.
4. Inspect the `guest_profiles` documents and the unique email index.
5. Save screenshots of the actual output in `evidence/`.

The scripts use `landmark_hotel_nosql`. They use upserts so that I can rerun the setup without creating duplicate guest profiles.
