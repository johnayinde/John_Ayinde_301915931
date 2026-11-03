-- Fictional records used to test the Portfolio 1 model.
SET search_path TO landmark_hotel, public;

INSERT INTO guests (first_name, last_name, email, phone) VALUES
('Amina', 'Yusuf', 'amina.yusuf@example.com', '+2348000000101'),
('Chinedu', 'Okafor', 'chinedu.okafor@example.com', '+2348000000102'),
('Grace', 'Mensah', 'grace.mensah@example.com', '+2348000000103'),
('Daniel', 'Adeyemi', 'daniel.adeyemi@example.com', '+2348000000104');

INSERT INTO room_types (type_name, description, max_occupancy, base_rate) VALUES
('Standard', 'Comfortable standard room', 2, 35000.00),
('Deluxe', 'Larger room with upgraded amenities', 2, 55000.00),
('Suite', 'Premium suite with separate sitting area', 4, 95000.00);

INSERT INTO rooms (room_number, room_type_id, floor_number, operational_status)
SELECT '101', room_type_id, 1, 'in_service' FROM room_types WHERE type_name = 'Standard';
INSERT INTO rooms (room_number, room_type_id, floor_number, operational_status)
SELECT '102', room_type_id, 1, 'in_service' FROM room_types WHERE type_name = 'Standard';
INSERT INTO rooms (room_number, room_type_id, floor_number, operational_status)
SELECT '201', room_type_id, 2, 'in_service' FROM room_types WHERE type_name = 'Deluxe';
INSERT INTO rooms (room_number, room_type_id, floor_number, operational_status)
SELECT '301', room_type_id, 3, 'maintenance' FROM room_types WHERE type_name = 'Suite';

INSERT INTO bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'LH-2026-0001', guest_id, 'confirmed', 'Late arrival requested'
FROM guests WHERE email = 'amina.yusuf@example.com';
INSERT INTO bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'LH-2026-0002', guest_id, 'confirmed', NULL
FROM guests WHERE email = 'chinedu.okafor@example.com';
INSERT INTO bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'LH-2026-0003', guest_id, 'confirmed', 'Extra towels requested'
FROM guests WHERE email = 'grace.mensah@example.com';
INSERT INTO bookings (booking_reference, guest_id, booking_status, special_requests)
SELECT 'LH-2026-0004', guest_id, 'pending', NULL
FROM guests WHERE email = 'daniel.adeyemi@example.com';

-- Checkout is not part of the occupied range, so another stay can start that day.
INSERT INTO booking_rooms (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-11-10', DATE '2026-11-13', 45000.00, 'confirmed'
FROM bookings b CROSS JOIN rooms r
WHERE b.booking_reference = 'LH-2026-0001' AND r.room_number = '101';

INSERT INTO booking_rooms (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-11-13', DATE '2026-11-15', 45000.00, 'confirmed'
FROM bookings b CROSS JOIN rooms r
WHERE b.booking_reference = 'LH-2026-0002' AND r.room_number = '101';

INSERT INTO booking_rooms (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-11-11', DATE '2026-11-14', 55000.00, 'confirmed'
FROM bookings b CROSS JOIN rooms r
WHERE b.booking_reference = 'LH-2026-0003' AND r.room_number = '201';

INSERT INTO booking_rooms (booking_id, room_id, check_in, check_out, nightly_rate, reservation_status)
SELECT b.booking_id, r.room_id, DATE '2026-12-01', DATE '2026-12-03', 95000.00, 'pending'
FROM bookings b CROSS JOIN rooms r
WHERE b.booking_reference = 'LH-2026-0004' AND r.room_number = '301';

INSERT INTO payments (booking_id, payment_reference, amount, currency, payment_method, payment_status, paid_at)
SELECT booking_id, 'PAY-LH-0001', 135000.00, 'NGN', 'card', 'successful', CURRENT_TIMESTAMP
FROM bookings WHERE booking_reference = 'LH-2026-0001';
INSERT INTO payments (booking_id, payment_reference, amount, currency, payment_method, payment_status, paid_at)
SELECT booking_id, 'PAY-LH-0002', 50000.00, 'NGN', 'bank_transfer', 'successful', CURRENT_TIMESTAMP
FROM bookings WHERE booking_reference = 'LH-2026-0002';
INSERT INTO payments (booking_id, payment_reference, amount, currency, payment_method, payment_status)
SELECT booking_id, 'PAY-LH-0003', 165000.00, 'NGN', 'online', 'pending'
FROM bookings WHERE booking_reference = 'LH-2026-0003';
