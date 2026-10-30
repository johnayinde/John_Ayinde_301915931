# Replication, Sharding, Availability and Consistency

## Replication
Replication maintains copies of data on different database instances. In the proposed design, PostgreSQL primary handles writes and a read replica supports reporting.

- **Synchronous replication:** A commit may wait for acknowledgement from a synchronous standby, strengthening durability across nodes but potentially increasing latency or reducing write availability during failures.
- **Asynchronous replication:** The primary can acknowledge a commit before the replica receives it, improving write responsiveness but allowing replication lag and possible loss of the latest acknowledged changes in some failure scenarios.
- **Monitoring:** Track replica status and lag; test promotion and recovery procedures.
- **Important distinction:** Replicas improve availability/read scaling but do not replace independent backups.

## Sharding
Sharding splits data across multiple database partitions or nodes. It can distribute storage and workload, but adds routing, rebalancing, operational and cross-shard query complexity.

For a small single-hotel academic system, sharding is not justified by the sample data. If the business expanded to many properties and the data volume required it, a property or region key could be evaluated as a shard key. The design would need to handle cross-property reporting and any booking operations that span shards.

## Availability and CAP-style trade-offs
During a network partition, a distributed system may have to choose between rejecting/delaying some operations to protect consistency or continuing to serve requests that may be stale. For hotel reservations, avoiding double-booking is more important than accepting a possibly conflicting reservation. For non-critical preference display or analytics, a short delay may be acceptable.

## ACID and eventual consistency
- PostgreSQL transactions and constraints provide the primary consistency boundary for booking/payment operations.
- Read replicas may be slightly behind the primary if asynchronous replication is used.
- MongoDB guest preferences are separate from the PostgreSQL booking transaction; the application must define how updates are coordinated and how partial failures are handled.
- Do not claim that a transaction across PostgreSQL and MongoDB is atomic unless a real distributed transaction mechanism is implemented and verified.

## Evidence to capture if implemented
- Actual deployment/connection configuration with secrets removed.
- Database version and node/replica status.
- Replication status/lag output.
- A read-only query against the replica.
- A backup and restore test result.
- Any failover test performed in a safe test environment.

If you do not implement a live distributed setup, label this as a design proposal and explain the trade-offs instead of fabricating deployment evidence.
