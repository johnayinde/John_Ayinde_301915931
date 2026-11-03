-- Demonstration run in the landmark_hotel_db test database.
SET search_path TO landmark_hotel, public;

-- Part A: this payment remains after COMMIT and is removed by the cleanup script.
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

-- Part B: this change is temporary and should disappear after ROLLBACK.
BEGIN;
UPDATE landmark_hotel.bookings
SET special_requests = 'TEMPORARY CHANGE FOR ROLLBACK DEMO'
WHERE booking_reference = 'LH-2026-0001';

-- Check the value while the transaction is still open.
SELECT booking_reference, special_requests
FROM landmark_hotel.bookings
WHERE booking_reference = 'LH-2026-0001';

ROLLBACK;

-- Check the value again after rollback.
SELECT booking_reference, special_requests
FROM landmark_hotel.bookings
WHERE booking_reference = 'LH-2026-0001';
