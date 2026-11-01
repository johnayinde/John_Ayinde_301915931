# Two-Session Test: Preventing a Double Booking

## Aim

I use two transactions to show what happens when two users try to reserve room 102 for the same dates. The important result is the one PostgreSQL actually returns, so I will save that output rather than alter it to fit an expected answer.

## Before I start

1. Use the test `landmark_hotel_db` database with the Portfolio 1 sample data loaded.
2. Run `John_Ayinde_301915931_OverlapConstraint.sql` and confirm that the constraint was created.
3. If the lab was run before, run `John_Ayinde_301915931_TestRecordCleanup.sql`.
4. Open two Query Tool sessions connected to the same database.

## Procedure

1. In Session A, run `John_Ayinde_301915931_SessionA.sql`. It starts a transaction and inserts a confirmed reservation for room 102 from 10 December 2026 to 13 December 2026. Leave the transaction open.
2. In Session B, run `John_Ayinde_301915931_SessionB.sql`. It attempts the same room and dates.
3. While Session B is waiting, return to Session A and run `COMMIT;`.
4. Session B should then return an exclusion-constraint error because the committed assignment overlaps its proposed stay.
5. Run `ROLLBACK;` in Session B to clear its failed transaction.
6. Once both sessions are closed or complete, run `John_Ayinde_301915931_TestRecordCleanup.sql`.
7. Save the constraint definition, Session A commit and Session B result, then complete `John_Ayinde_301915931_Results.md`.

## Why the rule works

The constraint compares the room identifier and the stay date range. The range is written as `[check_in, check_out)`, so the check-in date is included and the check-out date is not. This permits back-to-back stays but rejects dates that overlap.

## If my result differs

I will first check that both sessions use the same database, the `btree_gist` extension and constraint exist, and the required sample room and guests are present. If the result still differs, I will document it with the screenshots and explain the likely cause.
