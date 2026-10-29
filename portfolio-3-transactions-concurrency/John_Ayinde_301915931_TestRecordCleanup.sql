-- Run after both concurrency sessions have ended or been rolled back.
-- Removes only test records created by Portfolio 3.
BEGIN;

DELETE FROM landmark_hotel.booking_rooms br
USING landmark_hotel.bookings b
WHERE br.booking_id = b.booking_id
  AND b.booking_reference IN ('P3-CONC-A-001', 'P3-CONC-B-001');

DELETE FROM landmark_hotel.bookings
WHERE booking_reference IN ('P3-CONC-A-001', 'P3-CONC-B-001');

DELETE FROM landmark_hotel.payments
WHERE payment_reference = 'P3-DEMO-COMMIT-001';

COMMIT;

SELECT 'Portfolio 3 test bookings remaining' AS check_name, COUNT(*) AS row_count
FROM landmark_hotel.bookings
WHERE booking_reference IN ('P3-CONC-A-001', 'P3-CONC-B-001')
UNION ALL
SELECT 'Portfolio 3 test payments remaining', COUNT(*)
FROM landmark_hotel.payments
WHERE payment_reference = 'P3-DEMO-COMMIT-001';
