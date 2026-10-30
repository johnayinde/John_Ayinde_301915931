# Proposed Distributed and Cloud Architecture

## Status
This is a **proposed academic architecture**, not a statement that Landmark Hotel's live systems use these components. Add actual deployment details only if you personally implement and verify them.

## Requirements
The hotel system needs reliable booking and payment records, responsive room searches, reporting, recovery from failures and protection of guest information. The system must not allow two concurrent active reservations for the same room and dates.

## Proposed components
1. **Application/API layer:** Authenticates users, validates requests and separates guest, receptionist, manager and finance permissions.
2. **PostgreSQL primary:** Source of truth for guests, room inventory, bookings, room assignments and payments. Booking/payment writes use database transactions and constraints.
3. **PostgreSQL read replica:** Receives replicated data and serves suitable read-only reporting workloads. Replication lag may mean a report is briefly behind the primary.
4. **MongoDB guest profiles:** Stores flexible preferences and notification settings. PostgreSQL remains the source of truth for bookings, room allocation and payments.
5. **Encrypted backups:** Scheduled database backups stored separately from the primary environment, with retention and restore tests.
6. **Monitoring and logging:** Tracks availability, replication lag, storage, query latency, errors and failed login attempts.
7. **Network/security controls:** TLS in transit, least-privilege database roles, secrets management, network restrictions and audited administrative access.

## Request flow
- Booking creation and payment-status updates go to PostgreSQL primary.
- Availability checks read current PostgreSQL data and must apply overlap logic/constraints.
- Reporting queries may use the read replica if a short delay is acceptable.
- Guest preference reads/writes use MongoDB, with an explicit policy for profile updates and application-level association to the PostgreSQL guest record.
- Backups are not a substitute for replication, and replication is not a substitute for backups.

## Availability and recovery
A production design should define recovery point objective (RPO) and recovery time objective (RTO), monitor replication health, test restore procedures, and document how a replica would be promoted if the primary fails. Failover must avoid split-brain writes. The exact RPO/RTO cannot be claimed until an actual platform and configuration are selected and tested.

## Consistency choices
Bookings, room allocation and payments need strong transactional correctness. Reporting can tolerate a replica being slightly behind if the report is labelled/understood as read-only and potentially stale. Flexible preference data can tolerate asynchronous propagation only if the application accepts and handles that trade-off.

## Scaling
Start with a well-indexed PostgreSQL database and a read replica for read-heavy reporting if workload justifies it. Do not shard a small hotel database without evidence of a scaling need. If growth eventually requires sharding, a property/region key could be evaluated, but cross-property reservations, global reports, rebalancing and cross-shard transactions add complexity.

## Security
- Use distinct database roles for the application, reporting and administrators.
- Grant only the permissions required for each role.
- Encrypt network traffic and backups.
- Store secrets outside GitHub.
- Monitor and audit privileged access.
- Avoid real guest/payment data in the academic portfolio.

## Limitations
This document describes a design. It is not evidence of a real cloud deployment or tested failover. If no cloud deployment is performed, say so clearly and submit the diagram plus the reasoned design discussion as the permitted discussion-based exercise.
