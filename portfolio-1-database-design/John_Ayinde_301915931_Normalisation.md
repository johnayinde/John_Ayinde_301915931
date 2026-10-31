# Normalisation Notes

I normalised the hotel data so that each table has one clear purpose and changes to one type of information do not create inconsistent copies elsewhere.

## First Normal Form (1NF)

Each table has a primary key and each column holds one value. For example, rooms on a booking are not kept as a comma-separated list in `bookings`; each assignment is a separate row in `booking_rooms`.

## Second Normal Form (2NF)

Each table uses a single-column primary key, and its non-key columns describe that record. Guest details are not mixed with room details, and payment information is not stored in the booking header. The `booking_rooms` table exists because a room assignment has its own dates, rate and status.

## Third Normal Form (3NF)

Details are stored with the entity they describe: guest data in `guests`, room-type details in `room_types`, room inventory in `rooms`, booking-level information in `bookings`, stay details in `booking_rooms`, and payments in `payments`.

The `nightly_rate` in `booking_rooms` is intentional. It records the rate agreed for that stay, which should not change if the current standard rate in `room_types` changes later.

## Avoiding duplication

- Guest contact details are stored once and linked through `guest_id`.
- Room-type details are stored once and linked through `room_type_id`.
- Booking details are stored once and linked through `booking_id`.
- Payments are separate records so one booking can have a deposit, balance payment or refund.

Booking totals can be calculated from room assignments and payments when needed. If the system later needs taxes, discounts or a final locked total, those rules should be stored explicitly rather than copied into unrelated tables.

## Summary

Separating the data this way reduces update anomalies and makes the integrity rules easier to enforce. Primary keys identify rows, foreign keys maintain relationships, and constraints reject invalid values.
