# Portfolio 2: Query Processing and Optimisation

In this portfolio, I use the Landmark Hotel data to write business queries and compare a query plan before and after adding an index. The aim is not to assume that an index is always faster; it is to use PostgreSQL's actual execution plan and timing to explain what happened in my test.

## Before running the files

- Load the Portfolio 1 schema and sample data into `landmark_hotel_db`.
- Use PostgreSQL 14 or later with pgAdmin or `psql`.
- The benchmark data is stored separately in `landmark_hotel_bench`. It does not change the hotel tables or the Portfolio 3 reservation tests.

## Run order

1. Run `John_Ayinde_301915931_BusinessQueries.sql` and check the results.
2. Run `John_Ayinde_301915931_BenchmarkSetup.sql`. It drops and recreates only `landmark_hotel_bench.payment_events`, so it should not be run against a table containing other work.
3. Run `John_Ayinde_301915931_BaselineExplain.sql` and save the complete output.
4. Run `John_Ayinde_301915931_OptimizedExplain.sql` and save the complete output.
5. Record the values from both plans in `John_Ayinde_301915931_PerformanceLog.csv`, then complete `John_Ayinde_301915931_PerformanceAnalysis.md`.
6. Save the required screenshots listed in `evidence/John_Ayinde_301915931_EvidenceREADME.md`.
7. If needed, run `John_Ayinde_301915931_BenchmarkCleanup.sql` to remove the benchmark schema.

## Reading the plans

- A `Seq Scan` reads rows from the table in sequence.
- An `Index Scan` or `Bitmap Index Scan` uses an index to locate matching rows.
- An `Index Only Scan` can return data from the index when PostgreSQL's visibility information allows it.
- `Execution Time` is the time measured for that run.
- `Buffers: shared hit/read` shows shared-buffer activity. A read is not automatically a physical disk read because the operating system may already have the data cached.

PostgreSQL chooses a plan from its estimates of cost, row count and selectivity. I will report the plan PostgreSQL chose, even if the index does not improve the result. Repeated runs can differ because of caching, data size and machine load.
