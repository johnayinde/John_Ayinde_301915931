# Portfolio 5: Proposed Distributed and Cloud Architecture

## Scope of this portfolio

This is my proposed architecture for the Landmark Hotel system. It is a design exercise, not a claim that I have deployed a production cloud system or completed a failover test. If I add real deployment evidence later, I will identify exactly what I configured and tested.

## What the design needs to protect

The most sensitive operations are creating bookings, assigning rooms and recording payments. The design must avoid two active reservations for the same room and dates, protect guest information, keep data recoverable, and still allow managers to run reports.

## Main components

1. **Application/API** — authenticates users, validates requests and applies separate permissions for guests, reception, management and finance.
2. **PostgreSQL primary** — holds the authoritative guest, room, booking, room-assignment and payment data. Booking and payment writes use transactions and database constraints.
3. **PostgreSQL read replica** — serves read-only reports where a small delay is acceptable. A report may be behind the primary while replication catches up.
4. **MongoDB guest profiles** — holds flexible preferences and notification settings only. It is not the source of truth for bookings, room allocation or payments.
5. **Backups** — encrypted backups are stored separately and need retention rules plus regular restore tests.
6. **Monitoring and logging** — tracks availability, storage, replication lag, slow queries, errors and failed sign-in attempts.
7. **Security controls** — TLS, restricted network access, least-privilege roles, managed secrets and audited administration.

## How requests are handled

Booking creation, room assignment and payment changes go to the PostgreSQL primary. Availability checks must use current primary data and the overlap rule. Read-heavy reports can use the replica when the user accepts that the result may be slightly behind. MongoDB handles preference changes through the application, which must also manage the link to the PostgreSQL guest record.

Replication does not replace backups, and backups do not provide a live replica. Both are needed for different failure scenarios.

## Recovery and consistency

A real deployment would need stated recovery point and recovery time targets, monitoring for replication health, tested restores, and a documented promotion process if the primary fails. The promotion process must avoid two nodes accepting conflicting writes.

For this hotel scenario, bookings, room allocation and payments need strong transactional correctness. Reporting can tolerate a small amount of replica lag when that limitation is understood. Preference data may tolerate asynchronous handling only when the application can handle a delayed or failed update.

## Scaling decision

I would begin with a properly indexed PostgreSQL primary and add a read replica only when reporting load requires it. Sharding is not justified by this single-hotel sample dataset. If the business later expanded across many properties, property or region could be evaluated as a shard key, but cross-property reports, rebalancing and cross-shard transactions would need careful design.

## Limitation

This document explains a reasoned design. It is not evidence of a live deployment, replication configuration or tested failover.
