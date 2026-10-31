# Portfolio 1: Landmark Hotel Reservation System

## Purpose

For this portfolio, I modelled the day-to-day reservation work of a fictional hotel called Landmark Hotel. The aim is to keep guest, room, booking and payment information in a structure that staff can use reliably. All records in the sample data are fictional.

## Intended users

- Guests provide contact details and make reservations.
- Reception staff register guests, create bookings and assign rooms.
- Managers review room use and booking activity.
- Finance staff record payments and prepare revenue reports.

## Data in the system

The database stores guest contact details; room types and their standard rates; individual rooms and their operating status; bookings; room assignments and stay dates; and payment records. I kept the booking header separate from room assignments because one booking can cover more than one room.

## Main tasks supported

1. Register a guest and update contact details.
2. Maintain room types and room inventory.
3. Create a booking for a guest.
4. Add one or more rooms to that booking with the relevant stay dates and agreed rate.
5. Check whether a room can be used for a requested date range.
6. Record deposits, final payments, failed payments and refunds.
7. Retrieve booking history and produce simple occupancy or revenue information.

## Assumptions made in the design

- A booking belongs to one guest, but it can have several room assignments.
- A room assignment identifies one room and one stay period.
- Check-out is exclusive. A guest checking out on a date does not prevent another guest from checking in on that same date.
- A room being in service, under maintenance or out of service is different from its availability for a particular date.
- A booking can have more than one payment, such as a deposit and a balance payment.
- Availability depends on room status and active overlapping stays.

## Why I used PostgreSQL

This scenario has clear relationships between entities and needs rules that should be enforced by the database. PostgreSQL provides foreign keys, check constraints and transactions for those rules. It also gives me a basis for the query-planning and concurrency work in the later portfolios.
