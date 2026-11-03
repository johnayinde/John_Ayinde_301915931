-- Run this after recording the baseline plan.
-- The composite index targets the status filter, date condition and sort order.
CREATE INDEX IF NOT EXISTS idx_payment_events_status_paid_at
ON landmark_hotel_bench.payment_events (payment_status, paid_at DESC)
INCLUDE (payment_id, booking_reference, amount);

ANALYZE landmark_hotel_bench.payment_events;

EXPLAIN (ANALYZE, BUFFERS, VERBOSE)
SELECT payment_id, booking_reference, amount, paid_at
FROM landmark_hotel_bench.payment_events
WHERE payment_status = 'successful'
  AND paid_at >= CURRENT_TIMESTAMP - INTERVAL '14 days'
ORDER BY paid_at DESC;
