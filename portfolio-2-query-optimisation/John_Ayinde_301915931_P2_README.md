# Portfolio 2 — Query Processing and Optimisation

## Objective
Write useful SQL queries for the Landmark Hotel system, inspect execution plans, test an index and explain the measured result.

## Prerequisites
- Portfolio 1 schema and seed data must be loaded into `landmark_hotel_db`.
- PostgreSQL 14+ and pgAdmin or `psql`.
- The benchmark uses a separate schema, `landmark_hotel_bench`, so generated test records do not affect the main hotel tables or Portfolio 3 reservation tests.

## Run order
1. Run `John_Ayinde_301915931_P2_BusinessQueries.sql` and inspect each result.
2. Run `John_Ayinde_301915931_P2_BenchmarkSetup.sql` once when ready. **It drops and recreates only `landmark_hotel_bench.payment_events`.** Do not run it if you have stored other work in that exact benchmark table.
3. Run `John_Ayinde_301915931_P2_BaselineExplain.sql` and save the complete output.
4. Run `John_Ayinde_301915931_P2_OptimizedExplain.sql` and save the complete output.
5. Enter your actual results in `John_Ayinde_301915931_P2_PerformanceLog.csv` and complete `John_Ayinde_301915931_P2_PerformanceAnalysis.md`.
6. Follow `evidence/John_Ayinde_301915931_P2_EvidenceREADME.md`.
7. Optional: run `John_Ayinde_301915931_P2_BenchmarkCleanup.sql` to remove only the benchmark schema.

## Query plan interpretation
- `Seq Scan`: reads the table sequentially.
- `Index Scan` / `Bitmap Index Scan`: uses an index to locate relevant rows.
- `Index Only Scan`: may return needed columns from the index if visibility information permits.
- `Execution Time`: measured execution time for that run.
- `Buffers: shared hit/read`: reports shared-buffer activity; a read is not necessarily a physical disk read because operating-system caching may be involved.

PostgreSQL decides which plan is cheapest based on its statistics, row counts, selectivity and environment. Do not force an index or claim it improved performance unless your own results support that conclusion. Repeat runs can vary due to cache warmth and machine load.
