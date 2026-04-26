-- =============================================================================
-- Bootstrap: Submission Status Types
-- Purpose: High-level categorization of submission results
-- =============================================================================

INSERT INTO submission_status_types (id, name, description)
VALUES
    (1, 'Successful', 'Code executed successfully'),
    (2, 'Failed', 'Code execution or test failed'),
    (3, 'Timeout', 'Code execution timed out'),
    (4, 'Error', 'System or compilation error')
ON CONFLICT (id) DO NOTHING;
