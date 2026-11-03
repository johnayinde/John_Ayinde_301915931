-- Adds the overlap rule after the Portfolio 1 sample data is loaded.
-- Creating btree_gist requires the relevant database permission.
CREATE EXTENSION IF NOT EXISTS btree_gist;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM pg_constraint c
        JOIN pg_class t ON t.oid = c.conrelid
        JOIN pg_namespace n ON n.oid = t.relnamespace
        WHERE c.conname = 'ex_booking_rooms_no_active_overlap'
          AND n.nspname = 'landmark_hotel'
          AND t.relname = 'booking_rooms'
    ) THEN
        ALTER TABLE landmark_hotel.booking_rooms
        ADD CONSTRAINT ex_booking_rooms_no_active_overlap
        EXCLUDE USING gist (
            room_id WITH =,
            daterange(check_in, check_out, '[)') WITH &&
        )
        WHERE (reservation_status IN ('pending', 'confirmed', 'checked_in'));
    END IF;
END $$;

-- Confirm that PostgreSQL created the constraint.
SELECT conname, pg_get_constraintdef(oid) AS definition
FROM pg_constraint
WHERE conrelid = 'landmark_hotel.booking_rooms'::regclass
  AND conname = 'ex_booking_rooms_no_active_overlap';
