-- Portfolio 1: Landmark Hotel Reservation System
-- PostgreSQL schema. Sample data is fictional.
-- Run this script in the landmark_hotel_db database.

CREATE SCHEMA IF NOT EXISTS landmark_hotel;
SET search_path TO landmark_hotel, public;

CREATE TABLE guests (
    guest_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(80) NOT NULL CHECK (length(trim(first_name)) > 0),
    last_name VARCHAR(80) NOT NULL CHECK (length(trim(last_name)) > 0),
    email VARCHAR(254) NOT NULL UNIQUE,
    phone VARCHAR(30),
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE room_types (
    room_type_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    max_occupancy SMALLINT NOT NULL CHECK (max_occupancy > 0),
    base_rate NUMERIC(12, 2) NOT NULL CHECK (base_rate >= 0)
);

CREATE TABLE rooms (
    room_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id BIGINT NOT NULL REFERENCES room_types(room_type_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    floor_number SMALLINT CHECK (floor_number >= 0),
    operational_status VARCHAR(20) NOT NULL DEFAULT 'in_service'
        CHECK (operational_status IN ('in_service', 'maintenance', 'out_of_service'))
);

CREATE TABLE bookings (
    booking_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_reference VARCHAR(24) NOT NULL UNIQUE,
    guest_id BIGINT NOT NULL REFERENCES guests(guest_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    booked_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    booking_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (booking_status IN ('pending', 'confirmed', 'cancelled', 'completed')),
    special_requests TEXT
);

CREATE TABLE booking_rooms (
    booking_room_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id BIGINT NOT NULL REFERENCES bookings(booking_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    room_id BIGINT NOT NULL REFERENCES rooms(room_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    nightly_rate NUMERIC(12, 2) NOT NULL CHECK (nightly_rate >= 0),
    reservation_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (reservation_status IN ('pending', 'confirmed', 'checked_in', 'checked_out', 'cancelled', 'no_show')),
    CONSTRAINT ck_booking_room_dates CHECK (check_out > check_in)
);

CREATE TABLE payments (
    payment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    booking_id BIGINT NOT NULL REFERENCES bookings(booking_id) ON UPDATE RESTRICT ON DELETE RESTRICT,
    payment_reference VARCHAR(64) UNIQUE,
    amount NUMERIC(12, 2) NOT NULL CHECK (amount > 0),
    currency CHAR(3) NOT NULL DEFAULT 'NGN',
    payment_method VARCHAR(20) NOT NULL
        CHECK (payment_method IN ('card', 'cash', 'bank_transfer', 'online')),
    payment_status VARCHAR(20) NOT NULL DEFAULT 'pending'
        CHECK (payment_status IN ('pending', 'successful', 'failed', 'refunded')),
    paid_at TIMESTAMPTZ,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_currency_uppercase CHECK (currency = upper(currency))
);

-- Helpful foreign-key indexes for common joins and lookups.
CREATE INDEX idx_rooms_room_type_id ON rooms(room_type_id);
CREATE INDEX idx_bookings_guest_id ON bookings(guest_id);
CREATE INDEX idx_booking_rooms_booking_id ON booking_rooms(booking_id);
CREATE INDEX idx_booking_rooms_room_dates ON booking_rooms(room_id, check_in, check_out);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_payments_status ON payments(payment_status);

-- Note: date-overlap prevention for concurrent reservations is an advanced
-- PostgreSQL constraint. It is intentionally kept for Portfolio 3 so you can
-- implement and test concurrency controls as a separate assessed activity.
