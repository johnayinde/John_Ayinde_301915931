-- Run after benchmark_setup.sql. Save the entire plan output as baseline evidence.
-- This removes only the index created by the optimised test, if it exists.
DROP INDEX IF EXISTS landmark_hotel_bench.idx_payment_events_status_paid_at;
ANALYZE landmark_hotel_bench.payment_events;

EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT payment_id, booking_reference, amount, paid_at
FROM landmark_hotel_bench.payment_events
WHERE payment_status = 'successful'
  AND paid_at >= CURRENT_TIMESTAMP - INTERVAL '14 days'
ORDER BY paid_at DESC;
