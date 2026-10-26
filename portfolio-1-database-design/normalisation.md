# Normalisation Notes

## First Normal Form (1NF)

Each table has a primary key and each field stores one value rather than a list of values. For example, a guest's email and phone are separate columns, and multiple rooms assigned to a booking are represented by separate rows in `booking_rooms` rather than a comma-separated list in `bookings`.

## Second Normal Form (2NF)

The tables use single-column primary keys. Non-key attributes describe the entity represented by that key. Room details are not mixed with guest details, and payment attributes are not stored in the booking header. The `booking_rooms` table represents each room assignment as its own row.

## Third Normal Form (3NF)

Non-key attributes are stored with the entity they describe. Guest names and contact details are in `guests`; room category descriptions and standard rates are in `room_types`; individual room numbers and operational status are in `rooms`; booking-level details are in `bookings`; stay dates and the agreed nightly rate are in `booking_rooms`; and payment details are in `payments`.

The agreed `nightly_rate` in `booking_rooms` is a historical rate for that specific stay. It is intentionally stored separately from the current standard rate in `room_types`, because the price agreed for a booking should not change automatically when the hotel's standard rate changes.

## Avoiding unnecessary duplication

- Guest contact information is stored once in `guests` and referenced by `guest_id`.
- Room type information is stored once in `room_types` and referenced by `room_type_id`.
- Booking details are stored once in `bookings` and referenced by `booking_id`.
- Payment details are stored in `payments`, allowing multiple payments for one booking.
- A booking total can be calculated from its room assignments and payments when needed rather than copied into several tables. If taxes, discounts or a locked final total are introduced later, their rules should be modelled explicitly.

## Conclusion

The design separates entities and their relationships to reduce update anomalies and improve data integrity. Primary keys identify records, foreign keys enforce relationships, and check/unique constraints prevent several categories of invalid data. The design should be tested with realistic examples before submission.
