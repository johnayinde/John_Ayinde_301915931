# Two-Session Concurrency Lab: Preventing Double-Booking

## Objective
Show how a database constraint prevents two concurrent transactions from reserving the same room for overlapping dates.

## Before starting
1. Use your test `landmark_hotel_db` database.
2. Ensure Portfolio 1 seed data exists.
3. Run `John_Ayinde_301915931_OverlapConstraint.sql` successfully.
4. Run `John_Ayinde_301915931_TestRecordCleanup.sql` if this lab has been run before.
5. In pgAdmin, open two separate Query Tool sessions connected to the same database. Keep both sessions open.

## Test procedure
1. In **Session A**, run `John_Ayinde_301915931_SessionA.sql`. It begins a transaction and inserts a confirmed reservation for room 102 from 10 December 2026 to 13 December 2026. Do not commit yet.
2. In **Session B**, run `John_Ayinde_301915931_SessionB.sql`. It attempts to reserve the same room for the same dates. Its room-assignment insert should wait because Session A holds an uncommitted conflicting row.
3. While Session B is waiting, switch to **Session A** and execute `COMMIT;`.
4. Session B should then receive an exclusion-constraint error because the reservation overlaps the committed reservation from Session A.
5. In Session B, execute `ROLLBACK;` to clear the failed transaction.
6. Run `John_Ayinde_301915931_TestRecordCleanup.sql` after both sessions are no longer in an open transaction.
7. Save screenshots of the constraint, Session A commit and Session B error. Record what actually happened in `John_Ayinde_301915931_Results.md`.

## Why it works
PostgreSQL's exclusion constraint checks the room identifier and the date range. The half-open interval `[check_in, check_out)` means checkout day is excluded from the occupied range, allowing one guest to check out on the same date another checks in. The constraint applies only to reservation statuses listed in the constraint predicate.

## If the test behaves differently
- Verify the constraint exists and the `btree_gist` extension was created.
- Verify room 102 and the two guest email addresses exist.
- Check that both sessions connect to the same database.
- If Session B errors immediately, confirm Session A inserted the room assignment before Session B was run.
- If Session B does not wait or fail as expected, capture the actual output and investigate rather than changing the result to match the expected outcome.
