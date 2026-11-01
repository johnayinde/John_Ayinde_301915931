# Replication, Sharding, Availability and Consistency

## Replication

In my proposed design, PostgreSQL primary accepts writes and a read replica supports reporting. Replication gives another copy of the data for read scaling and resilience, but it is not a replacement for an independent backup.

- **Synchronous replication** makes a commit wait for a standby acknowledgement. This can strengthen durability across nodes, but it can add latency and affect write availability during a failure.
- **Asynchronous replication** lets the primary acknowledge a commit before the replica has it. This is usually more responsive, but the replica can lag and the most recent acknowledged changes may be at risk in some failures.
- In either case, replica status, lag, promotion and recovery should be monitored and tested.

## Sharding

Sharding splits data between database nodes. It can help at much larger scale, but it also creates routing, rebalancing and cross-shard query problems.

For this single-hotel academic system, I would not shard the sample data. If a future version supported many properties with enough volume to justify it, property or region could be considered as a shard key. The design would then need a clear approach for cross-property reporting and any booking operation that crosses shards.

## Availability and consistency

During a network partition, a distributed system may need to delay or reject some requests to avoid accepting inconsistent writes. For room reservations, preventing a double booking is more important than accepting a booking that could conflict. A short delay is more acceptable for analytics or displaying non-critical preferences.

PostgreSQL transactions and constraints are therefore the main consistency boundary for bookings and payments. A read replica can be slightly behind when asynchronous replication is used. MongoDB preferences are outside the PostgreSQL booking transaction, so the application must define what happens if one system succeeds and the other fails. I do not claim cross-database atomicity because this portfolio does not implement or test a distributed transaction mechanism.

## Evidence if I implement the design

- deployment configuration with credentials removed;
- database version plus primary/replica status;
- replication lag output;
- a read-only query against the replica;
- backup and restore results; and
- any safe failover test performed.

Without those tests, this remains a design proposal rather than a deployed solution.
