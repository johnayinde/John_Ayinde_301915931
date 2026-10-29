-- Run against the academic/test database landmark_hotel_db.
SET search_path TO landmark_hotel, public;

-- PART A: COMMIT demo. This leaves one clearly named test payment until cleanup.
BEGIN;
INSERT INTO payments (booking_id, payment_reference, amount, currency, payment_method, payment_status, paid_at)
SELECT booking_id, 'P3-DEMO-COMMIT-001', 1000.00, 'NGN', 'bank_transfer', 'successful', CURRENT_TIMESTAMP
FROM bookings
WHERE booking_reference = 'LH-2026-0001'
ON CONFLICT (payment_reference) DO NOTHING;
COMMIT;

SELECT payment_reference, booking_id, amount, payment_status, paid_at
FROM landmark_hotel.payments
WHERE payment_reference = 'P3-DEMO-COMMIT-001';

-- PART B: ROLLBACK demo. The temporary update should NOT remain after ROLLBACK.
BEGIN;
UPDATE landmark_hotel.bookings
SET special_requests = 'TEMPORARY CHANGE FOR ROLLBACK DEMO'
WHERE booking_reference = 'LH-2026-0001';

-- Inspect the temporary value inside the transaction.
SELECT booking_reference, special_requests
FROM landmark_hotel.bookings
WHERE booking_reference = 'LH-2026-0001';

ROLLBACK;

-- Inspect again. The original value should have been restored.
SELECT booking_reference, special_requests
FROM landmark_hotel.bookings
WHERE booking_reference = 'LH-2026-0001';
