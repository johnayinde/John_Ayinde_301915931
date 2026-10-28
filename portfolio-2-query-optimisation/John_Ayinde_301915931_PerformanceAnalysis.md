# Portfolio 2 — Query Performance Analysis

> Complete this report after running the scripts. Do not submit the placeholders as results or invent execution times.

## Environment
- PostgreSQL version: [record from `SELECT version();`]
- Operating system/device: [record your environment]
- Tool: [pgAdmin Query Tool or psql]
- Test date/time: [record]
- Benchmark rows: [record output from `John_Ayinde_301915931_BenchmarkSetup.sql`]

## Query under test
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

The index is designed to support the equality condition on `payment_status`, the date filter and ordering by `paid_at`. The included columns may allow PostgreSQL to return the requested values from the index, depending on the selected plan and visibility map.

## Results table — fill from your actual EXPLAIN output

| Metric | Baseline | After index |
|---|---|---|
| Planning time (ms) | [actual] | [actual] |
| Execution time (ms) | [actual] | [actual] |
| Main plan node | [actual] | [actual] |
| Rows returned | [actual] | [actual] |
| Shared buffer hits | [actual] | [actual] |
| Shared buffer reads | [actual] | [actual] |

## Analysis prompts
1. What plan node did PostgreSQL choose before the index was created?
2. What plan node did it choose after the index was created?
3. Did the execution time improve in your run? Quote the measured values.
4. Did buffer activity change? What might explain the difference?
5. Did both queries return the same logical results? Explain any small difference caused by the moving time window, if applicable.
6. What limitations affected the measurement (warm cache, machine load, dataset size, PostgreSQL version or repeated runs)?

## Conclusion — write in your own words
[Write 3–5 sentences explaining what you observed, whether the index changed the plan, what the measurements show, and what you learned. If the index did not improve the result, state that honestly and discuss why.]
