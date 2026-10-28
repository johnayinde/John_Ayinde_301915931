-- Run these queries after John_Ayinde_301915931_Schema.sql and John_Ayinde_301915931_SampleData.sql.
SET search_path TO landmark_hotel, public;

-- 1. Show all rooms with their room categories.
SELECT r.room_number, r.floor_number, r.operational_status,
       rt.type_name, rt.max_occupancy, rt.base_rate
FROM rooms r
JOIN room_types rt ON rt.room_type_id = r.room_type_id
ORDER BY r.room_number;

-- 2. Show bookings with guest names and assigned rooms.
SELECT b.booking_reference, g.first_name, g.last_name,
       r.room_number, br.check_in, br.check_out,
       br.nightly_rate, br.reservation_status
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
JOIN booking_rooms br ON br.booking_id = b.booking_id
JOIN rooms r ON r.room_id = br.room_id
ORDER BY b.booking_reference;

-- 3. Find rooms that are operational and have no active reservation
-- overlapping the requested stay (10-13 November 2026).
SELECT r.room_number, rt.type_name, rt.base_rate
FROM rooms r
JOIN room_types rt ON rt.room_type_id = r.room_type_id
WHERE r.operational_status = 'in_service'
  AND NOT EXISTS (
      SELECT 1
      FROM booking_rooms br
      WHERE br.room_id = r.room_id
        AND br.reservation_status IN ('pending', 'confirmed', 'checked_in')
        AND br.check_in < DATE '2026-11-13'
        AND br.check_out > DATE '2026-11-10'
  )
ORDER BY r.room_number;

-- 4. Summarise successful payments by booking.
SELECT b.booking_reference,
       COALESCE(SUM(p.amount) FILTER (WHERE p.payment_status = 'successful'), 0) AS successful_payments,
       COUNT(p.payment_id) AS payment_records
FROM bookings b
LEFT JOIN payments p ON p.booking_id = b.booking_id
GROUP BY b.booking_id, b.booking_reference
ORDER BY b.booking_reference;

-- 5. Check the constraints by listing bookings with their guest email and status.
SELECT b.booking_reference, g.email, b.booking_status, b.booked_at
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
ORDER BY b.booked_at DESC;
