-- SESSION A: Run this script in Query Tool session A.
-- Do NOT COMMIT until Session B is waiting on its conflicting insert.
BEGIN;

INSERT INTO landmark_hotel.bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'P3-CONC-A-001', guest_id, 'confirmed', 'Portfolio 3 concurrency test session A'
FROM landmark_hotel.guests
WHERE email = 'amina.yusuf@example.com'
ON CONFLICT (booking_reference) DO NOTHING;

INSERT INTO landmark_hotel.booking_rooms
    (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-12-10', DATE '2026-12-13', 35000.00, 'confirmed'
FROM landmark_hotel.bookings b
JOIN landmark_hotel.rooms r ON r.room_number = '102'
WHERE b.booking_reference = 'P3-CONC-A-001'
  AND NOT EXISTS (
      SELECT 1 FROM landmark_hotel.booking_rooms br
      WHERE br.booking_id = b.booking_id
        AND br.room_id = r.room_id
        AND br.check_in = DATE '2026-12-10'
        AND br.check_out = DATE '2026-12-13'
  );

-- Stop here. Leave this transaction open while Session B tries the same room/dates.
