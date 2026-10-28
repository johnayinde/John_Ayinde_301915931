# Portfolio 1: Case Study - Landmark Hotel Reservation System

## 1. Organisation and system

For this academic project, Landmark Hotel is represented by a simulated hotel reservation operation. The database is intended to support hotel staff in managing guests, room inventory, bookings and payments. The sample records used in this repository are fictional and are not actual hotel customer data.

## 2. Users

- **Guests:** provide contact details and make reservations.
- **Receptionists:** register guests, create bookings and assign rooms.
- **Hotel managers:** review room usage and booking activity.
- **Finance staff:** record and reconcile payments and prepare revenue reports.

## 3. Data stored

The relational database stores:

- Guest names, email addresses and phone numbers.
- Room categories, descriptions, occupancy limits and standard rates.
- Room numbers, room types, floors and operational status.
- Booking references, guest links, booking timestamps and booking status.
- Room assignments, stay dates, agreed nightly rates and reservation status.
- Payment references, amounts, methods, statuses and timestamps.

## 4. Main operations

1. Register a guest and maintain their contact details.
2. Add room categories and room inventory.
3. Create a booking for a guest.
4. Assign one or more rooms to a booking with check-in and check-out dates.
5. Check room availability for a requested date range.
6. Record deposits, final payments, failed payments and refunds.
7. Retrieve a guest's booking history and summarise bookings or revenue.

## 5. Scope and assumptions

- Each booking belongs to one guest.
- A booking may contain one or more room assignments.
- Each room assignment refers to one room and one stay period.
- Check-out dates are exclusive: a room checking out on a date may be assigned to another guest checking in on that same date, provided the previous stay has ended.
- A room's operational status (in service, maintenance or out of service) is separate from date-specific availability.
- A booking may have multiple payment records, for example a deposit followed by a final payment.
- Room availability is determined from operational status and overlapping active reservations, not from the room's operational status alone.
- All sample data is fictional and created for learning purposes.

## 6. Why a relational database?

PostgreSQL is suitable because the system contains related entities, requires foreign-key integrity, benefits from constraints, and includes transactions such as booking a room and recording a payment. SQL also supports reporting and query optimisation activities in later portfolio tasks.
