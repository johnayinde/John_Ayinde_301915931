-- Portfolio 2 benchmark setup.
-- IMPORTANT: This resets only the dedicated benchmark table in schema landmark_hotel_bench.
-- It does not insert benchmark records into the operational landmark_hotel tables.

CREATE SCHEMA IF NOT EXISTS landmark_hotel_bench;
DROP TABLE IF EXISTS landmark_hotel_bench.payment_events;

CREATE TABLE landmark_hotel_bench.payment_events (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_reference VARCHAR(32) NOT NULL,
    amount NUMERIC(12,2) NOT NULL CHECK (amount > 0),
    payment_status VARCHAR(20) NOT NULL CHECK (payment_status IN ('successful','failed','pending','refunded')),
    payment_method VARCHAR(20) NOT NULL CHECK (payment_method IN ('card','cash','bank_transfer','online')),
    paid_at TIMESTAMPTZ NOT NULL
);

-- 200,000 fictional records with a distribution suitable for testing a selective filter.
INSERT INTO landmark_hotel_bench.payment_events
    (booking_reference, amount, payment_status, payment_method, paid_at)
SELECT 'BENCH-' || lpad(s.i::text, 8, '0'),
       (10000 + (s.i % 90000))::numeric(12,2),
       CASE s.i % 4
           WHEN 0 THEN 'successful'
           WHEN 1 THEN 'failed'
           WHEN 2 THEN 'pending'
           ELSE 'refunded'
       END,
       CASE s.i % 4
           WHEN 0 THEN 'card'
           WHEN 1 THEN 'bank_transfer'
           WHEN 2 THEN 'online'
           ELSE 'cash'
       END,
       CURRENT_TIMESTAMP - ((s.i % 731) * INTERVAL '1 day') - ((s.i % 24) * INTERVAL '1 hour')
FROM generate_series(1, 200000) AS s(i);

ANALYZE landmark_hotel_bench.payment_events;

SELECT COUNT(*) AS benchmark_rows,
       MIN(paid_at) AS oldest_payment,
       MAX(paid_at) AS newest_payment,
       COUNT(*) FILTER (WHERE payment_status = 'successful') AS successful_rows
FROM landmark_hotel_bench.payment_events;
