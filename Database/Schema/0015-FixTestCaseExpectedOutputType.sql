-- =============================================================================
-- Migration: Fix Test Case Expected Output Type
-- Purpose: Convert output_type from VARCHAR to FK relationship
-- This maintains consistency with test_cases_inputs which uses FK
-- =============================================================================

-- Step 1: Create the lookup table if it doesn't exist
CREATE TABLE IF NOT EXISTS test_cases_output_value_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Step 2: Seed standard output types
INSERT INTO test_cases_output_value_types (name) VALUES
    ('String'),
    ('Integer'),
    ('Float'),
    ('Array'),
    ('Boolean'),
    ('JSON')
ON CONFLICT (name) DO NOTHING;

-- Step 3: Add new FK column to test_cases_expected_outputs
ALTER TABLE test_cases_expected_outputs
ADD COLUMN IF NOT EXISTS output_value_type_id INT NULL;

-- Step 4: Migrate existing data from output_type string to FK
-- Map existing output_type strings to IDs
UPDATE test_cases_expected_outputs tco
SET output_value_type_id = tcovt.id
FROM test_cases_output_value_types tcovt
WHERE LOWER(tco.output_type) = LOWER(tcovt.name);

-- Step 5: For any rows that couldn't be mapped, default to 'String'
UPDATE test_cases_expected_outputs
SET output_value_type_id = (SELECT id FROM test_cases_output_value_types WHERE name = 'String')
WHERE output_value_type_id IS NULL;

-- Step 6: Make output_value_type_id NOT NULL
ALTER TABLE test_cases_expected_outputs
ALTER COLUMN output_value_type_id SET NOT NULL;

-- Step 7: Add FK constraint
ALTER TABLE test_cases_expected_outputs
ADD CONSTRAINT fk_test_cases_expected_outputs_output_type
    FOREIGN KEY (output_value_type_id) 
    REFERENCES test_cases_output_value_types(id) 
    ON DELETE RESTRICT;

-- Step 8: Drop old output_type column
ALTER TABLE test_cases_expected_outputs
DROP COLUMN output_type;

-- =============================================================================
-- Verification: Run these queries to confirm the migration
-- =============================================================================
-- SELECT COUNT(*) FROM test_cases_output_value_types;  -- Should be 6
-- SELECT tco.*, tcovt.name FROM test_cases_expected_outputs tco
--     JOIN test_cases_output_value_types tcovt ON tco.output_value_type_id = tcovt.id;
-- SELECT * FROM information_schema.key_column_usage 
--     WHERE table_name='test_cases_expected_outputs' 
--     AND constraint_name LIKE 'fk_%';
