-- Session B runs in a second Query Tool session while Session A remains open.
BEGIN;

INSERT INTO landmark_hotel.bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'P3-CONC-B-001', guest_id, 'confirmed', 'Portfolio 3 concurrency test session B'
FROM landmark_hotel.guests
WHERE email = 'chinedu.okafor@example.com'
ON CONFLICT (booking_reference) DO NOTHING;

-- This insert uses the same room and dates as Session A.
-- It should wait for Session A, then fail after Session A commits.
INSERT INTO landmark_hotel.booking_rooms
    (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-12-10', DATE '2026-12-13', 35000.00, 'confirmed'
FROM landmark_hotel.bookings b
JOIN landmark_hotel.rooms r ON r.room_number = '102'
WHERE b.booking_reference = 'P3-CONC-B-001';

-- The expected result is an exclusion-constraint violation.
-- Run ROLLBACK manually afterwards to clear Session B.
