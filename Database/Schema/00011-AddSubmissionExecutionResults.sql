ALTER TABLE submission_results
    ADD COLUMN IF NOT EXISTS execution_id UUID NULL;

ALTER TABLE submission_results
    ADD COLUMN IF NOT EXISTS result_id UUID NULL;

ALTER TABLE submission_results
    ADD COLUMN IF NOT EXISTS program_output TEXT NULL;

DELETE FROM submission_results
WHERE execution_id IS NULL;

ALTER TABLE submission_results
    ALTER COLUMN execution_id SET NOT NULL;