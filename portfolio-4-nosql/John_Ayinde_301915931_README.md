# Portfolio 4 — NoSQL and Advanced Data Models

## Objective
Implement a MongoDB document model for flexible guest preferences associated with the same Landmark Hotel Reservation System.

## Why MongoDB here?
Guest preferences may contain optional or changing fields (preferred room type, bed preference, accessibility needs, dietary notes and notification settings). A document can group these related fields together. Core bookings, room assignments and payment records remain in PostgreSQL because they require relational integrity and transactional controls in this project.

## Requirements
- MongoDB Community Server with `mongosh`, or a MongoDB Atlas deployment.
- Do not store real guest details, payment card data or secrets.

## Run
1. Start MongoDB or connect `mongosh` to your Atlas cluster.
2. Run `John_Ayinde_301915931_MongoSetup.js` using `mongosh < John_Ayinde_301915931_MongoSetup.js` from this folder, or paste the script into a connected shell. If using Atlas, first follow the Atlas connection instructions and make sure your database user and network access are configured securely.
3. Run `John_Ayinde_301915931_MongoQueries.js` in the same database context.
4. Inspect the `guest_profiles` collection and index.
5. Save actual screenshots/output in `evidence/`.

The scripts use `db.getSiblingDB('landmark_hotel_nosql')` and are designed to upsert the sample documents so rerunning them does not create duplicate profiles. The unique index on `guest_email` enforces one document per guest email.
