# Portfolio 3 — Transactions and Concurrency

## Objective
Demonstrate transaction commit/rollback and a control that prevents overlapping active reservations for the same room.

## Prerequisites
- Portfolio 1 schema and seed data are loaded.
- Use a local/test `landmark_hotel_db`, not a production database.
- Run `John_Ayinde_301915931_CommitRollbackDemo.sql` first.
- Run `John_Ayinde_301915931_OverlapConstraint.sql` before the concurrency lab.

## Files
- `John_Ayinde_301915931_CommitRollbackDemo.sql` — committed test payment and rolled-back booking update.
- `John_Ayinde_301915931_OverlapConstraint.sql` — exclusion constraint using `btree_gist` and a half-open date range.
- `John_Ayinde_301915931_ConcurrencyLab.md` — exact two-session test instructions.
- `John_Ayinde_301915931_SessionA.sql` and `John_Ayinde_301915931_SessionB.sql` — statements for two separate query sessions.
- `John_Ayinde_301915931_TestRecordCleanup.sql` — removes only the test records created by this lab.
- `John_Ayinde_301915931_Results.md` — report your actual observed results.
- `evidence/John_Ayinde_301915931_EvidenceREADME.md` — screenshots to collect.

## Commit and rollback demo
Run `John_Ayinde_301915931_CommitRollbackDemo.sql`. The payment record with reference `P3-DEMO-COMMIT-001` is committed and can be removed with the cleanup script. A temporary update to a booking is shown inside a transaction and then rolled back; after rollback the original value should remain.

## Reservation overlap protection
The exclusion constraint prevents active reservations for the same room from overlapping in date range. The range uses `[check_in, check_out)`, meaning checkout day is not occupied; a guest can check out on the same date the next guest checks in.

The constraint blocks overlap for `pending`, `confirmed` and `checked_in` assignments. The lab requires the `btree_gist` extension. If you lack permission to install it, do not silently skip the requirement: capture the error and discuss an alternative control mechanism with your lecturer.

## Concurrency lab warning
Use two separate pgAdmin Query Tool sessions connected to the same test database. Session A must remain open in an uncommitted transaction while Session B attempts the conflicting insert. Follow `John_Ayinde_301915931_ConcurrencyLab.md` exactly, then clean up the test records.
