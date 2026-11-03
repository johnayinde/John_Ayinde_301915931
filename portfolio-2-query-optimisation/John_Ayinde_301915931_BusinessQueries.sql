-- Business queries for the Landmark Hotel database.
SET search_path TO landmark_hotel, public;

-- Q1. Rooms with type, occupancy and standard rate.
SELECT r.room_number, r.floor_number, r.operational_status,
       rt.type_name, rt.max_occupancy, rt.base_rate
FROM rooms r
JOIN room_types rt ON rt.room_type_id = r.room_type_id
ORDER BY r.room_number;

-- Q2. Booking history for one guest.
SELECT b.booking_reference, b.booked_at, b.booking_status,
       r.room_number, br.check_in, br.check_out, br.nightly_rate,
       br.reservation_status
FROM guests g
JOIN bookings b ON b.guest_id = g.guest_id
JOIN booking_rooms br ON br.booking_id = b.booking_id
JOIN rooms r ON r.room_id = br.room_id
WHERE g.email = 'amina.yusuf@example.com'
ORDER BY br.check_in DESC;

-- Q3. Available rooms for a requested date range.
WITH requested_stay AS (
    SELECT DATE '2026-11-10' AS check_in, DATE '2026-11-13' AS check_out
)
SELECT r.room_number, rt.type_name, rt.base_rate
FROM rooms r
JOIN room_types rt ON rt.room_type_id = r.room_type_id
CROSS JOIN requested_stay s
WHERE r.operational_status = 'in_service'
  AND NOT EXISTS (
      SELECT 1 FROM booking_rooms br
      WHERE br.room_id = r.room_id
        AND br.reservation_status IN ('pending', 'confirmed', 'checked_in')
        AND br.check_in < s.check_out
        AND br.check_out > s.check_in
  )
ORDER BY rt.base_rate, r.room_number;

-- Q4. Successful collections by payment month.
SELECT date_trunc('month', p.paid_at)::date AS payment_month,
       p.currency,
       SUM(p.amount) AS successful_collections,
       COUNT(*) AS successful_payment_count
FROM payments p
WHERE p.payment_status = 'successful' AND p.paid_at IS NOT NULL
GROUP BY date_trunc('month', p.paid_at)::date, p.currency
ORDER BY payment_month, p.currency;

-- Q5. Booking counts by status.
SELECT booking_status, COUNT(*) AS booking_count
FROM bookings
GROUP BY booking_status
ORDER BY booking_count DESC, booking_status;

-- Q6. Room nights and scheduled charges by room type.
SELECT rt.type_name,
       SUM(br.check_out - br.check_in) AS booked_room_nights,
       SUM((br.check_out - br.check_in) * br.nightly_rate) AS scheduled_room_charges
FROM booking_rooms br
JOIN rooms r ON r.room_id = br.room_id
JOIN room_types rt ON rt.room_type_id = r.room_type_id
WHERE br.reservation_status IN ('confirmed', 'checked_in', 'checked_out')
GROUP BY rt.type_name
ORDER BY scheduled_room_charges DESC;

-- Q7. Payment summary for all bookings, including unpaid bookings.
SELECT b.booking_reference,
       COALESCE(SUM(p.amount) FILTER (WHERE p.payment_status = 'successful'), 0) AS successful_amount,
       COUNT(p.payment_id) AS payment_record_count
FROM bookings b
LEFT JOIN payments p ON p.booking_id = b.booking_id
GROUP BY b.booking_id, b.booking_reference
ORDER BY b.booking_reference;

-- Q8. Join with a selective filter used in the plan comparison.
SELECT b.booking_reference, g.email, p.amount, p.payment_status, p.paid_at
FROM bookings b
JOIN guests g ON g.guest_id = b.guest_id
JOIN payments p ON p.booking_id = b.booking_id
WHERE p.payment_status = 'successful'
ORDER BY p.paid_at DESC NULLS LAST;
