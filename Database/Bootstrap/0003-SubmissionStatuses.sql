-- =============================================================================
-- Bootstrap: Submission Statuses
-- Purpose: Detailed status values for submission results
-- =============================================================================

INSERT INTO submission_statuses (id, name, description, status_type_id)
VALUES
    (1, 'Accepted', 'All tests passed', 1),
    (2, 'Wrong Answer', 'Test output does not match expected result', 2),
    (3, 'Runtime Error', 'Code crashed or threw an exception', 2),
    (4, 'Time Limit Exceeded', 'Code execution took too long', 3),
    (5, 'Compilation Error', 'Code failed to compile', 2),
    (6, 'Memory Limit Exceeded', 'Code used too much memory', 2),
    (7, 'Output Limit Exceeded', 'Code produced too much output', 2),
    (8, 'Internal Server Error', 'System error during evaluation', 4)
ON CONFLICT (id) DO NOTHING;
