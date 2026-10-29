# Portfolio 3 — Results and Reflection

## Environment
- PostgreSQL version: [fill in]
- Tool: [pgAdmin / psql]
- Test date: [fill in]

## Commit demonstration
- What record was committed? [describe the test payment]
- Did the committed record remain visible after COMMIT? [actual result]

## Rollback demonstration
- What value was changed temporarily? [describe]
- What did the SELECT show inside the transaction? [actual result]
- What did the SELECT show after ROLLBACK? [actual result]

## Concurrency demonstration
- Did Session B wait while Session A was uncommitted? [actual result]
- What happened after Session A committed? [actual error/result]
- Which constraint enforced the rule? [constraint name]
- Why does the half-open date range allow back-to-back reservations? [explain]

## Reflection
[Write in your own words what the exercise taught you about atomicity, transaction boundaries and concurrent booking attempts.]
