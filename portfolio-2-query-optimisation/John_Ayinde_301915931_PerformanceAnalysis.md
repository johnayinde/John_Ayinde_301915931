# Portfolio 2: Query Performance Analysis

I will complete this report from the output of my own PostgreSQL runs. The placeholders are deliberately left here until I have captured the plans; no timing values should be guessed.

## Test environment

- PostgreSQL version: [output of `SELECT version();`]
- Operating system/device: [record environment]
- Tool used: [pgAdmin Query Tool or psql]
- Test date and time: [record]
- Benchmark rows: [output from `John_Ayinde_301915931_BenchmarkSetup.sql`]

## Query tested

```sql
SELECT payment_id, booking_reference, amount, paid_at
FROM landmark_hotel_bench.payment_events
WHERE payment_status = 'successful'
  AND paid_at >= CURRENT_TIMESTAMP - INTERVAL '14 days'
ORDER BY paid_at DESC;
```

## Index tested

```sql
CREATE INDEX idx_payment_events_status_paid_at
ON landmark_hotel_bench.payment_events (payment_status, paid_at DESC)
INCLUDE (payment_id, booking_reference, amount);
```

The index starts with `payment_status`, then supports the date condition and descending date order. The included columns may allow an index-only scan, but that depends on the plan PostgreSQL actually chooses and the visibility map at the time of the test.

## Results from my plans

| Metric | Before the index | After the index |
|---|---|---|
| Planning time (ms) | [actual] | [actual] |
| Execution time (ms) | [actual] | [actual] |
| Main plan node | [actual] | [actual] |
| Rows returned | [actual] | [actual] |
| Shared buffer hits | [actual] | [actual] |
| Shared buffer reads | [actual] | [actual] |

## Discussion to complete after testing

1. State the main plan node before and after the index.
2. Compare the measured execution times rather than assuming an improvement.
3. Explain any change in buffer activity.
4. Confirm whether both runs returned the same logical result. The moving 14-day window can cause a small difference if the runs are far apart.
5. Note relevant limits, such as a warm cache, machine load, data size, PostgreSQL version and repeat runs.

## Conclusion

[Write a short conclusion in my own words. It should say what plan PostgreSQL used, whether the index changed the measured result, and what I learned from the comparison.]
