-- =============================================================================
-- Bootstrap: Test Suite Types
-- Purpose: Categorize different types of test suites
-- =============================================================================

INSERT INTO test_suite_types (id, name, description)
VALUES
    (1, 'Hidden', 'Hidden test cases not visible to users until after submission'),
    (2, 'Public', 'Public example test cases visible to users before submission')
ON CONFLICT (id) DO NOTHING;
