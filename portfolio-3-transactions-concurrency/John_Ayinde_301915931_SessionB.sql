-- SESSION B: Run in a DIFFERENT Query Tool session while Session A is still open.
BEGIN;

INSERT INTO landmark_hotel.bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'P3-CONC-B-001', guest_id, 'confirmed', 'Portfolio 3 concurrency test session B'
FROM landmark_hotel.guests
WHERE email = 'chinedu.okafor@example.com'
ON CONFLICT (booking_reference) DO NOTHING;

-- This conflicting insert should wait while Session A is uncommitted.
-- After Session A commits, PostgreSQL should reject this insert with the exclusion constraint.
INSERT INTO landmark_hotel.booking_rooms
    (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-12-10', DATE '2026-12-13', 35000.00, 'confirmed'
FROM landmark_hotel.bookings b
JOIN landmark_hotel.rooms r ON r.room_number = '102'
WHERE b.booking_reference = 'P3-CONC-B-001';

-- Expected: the INSERT above fails with an exclusion-constraint violation.
-- After the error, run ROLLBACK; manually in Session B to clear the failed transaction.
