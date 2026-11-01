# Portfolio 3: Transactions and Concurrency

This portfolio focuses on two database behaviours that matter in a hotel system: whether a transaction is saved or reversed, and whether two users can reserve the same room for overlapping dates.

## Files in this folder

- `John_Ayinde_301915931_CommitRollbackDemo.sql` — shows one committed payment and one booking update that is rolled back.
- `John_Ayinde_301915931_OverlapConstraint.sql` — adds the PostgreSQL exclusion constraint used to stop active overlapping stays.
- `John_Ayinde_301915931_ConcurrencyLab.md` — instructions for the two-session test.
- `John_Ayinde_301915931_SessionA.sql` and `John_Ayinde_301915931_SessionB.sql` — the statements for each database session.
- `John_Ayinde_301915931_TestRecordCleanup.sql` — removes records created by the demonstration.
- `John_Ayinde_301915931_Results.md` — where I record the actual results after testing.

## What I am testing

I first run the commit/rollback script. The payment with reference `P3-DEMO-COMMIT-001` should remain after `COMMIT`. The booking update is made inside a separate transaction and then reversed with `ROLLBACK`, so the original value should remain.

I then add `ex_booking_rooms_no_active_overlap` to `landmark_hotel.booking_rooms`. It checks both `room_id` and a half-open date range, `[check_in, check_out)`. This means that a checkout date is available for the next guest's check-in, while genuinely overlapping stays are rejected.

The rule applies only to `pending`, `confirmed` and `checked_in` assignments. It needs the `btree_gist` extension. If I cannot create that extension in my test environment, I will record the error rather than claim that the constraint was installed.

## Test setup

Portfolio 1 must be loaded into a test copy of `landmark_hotel_db`. The concurrency demonstration needs two pgAdmin Query Tool sessions connected to that same database. I run the overlap-constraint script before opening the two-session test, then use the cleanup script after both sessions have finished.
