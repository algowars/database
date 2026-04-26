-- =============================================================================
-- Bootstrap: Problem Statuses
-- Purpose: Insert status types for problems
-- =============================================================================

INSERT INTO problem_statuses (id, name, description)
VALUES
    (1, 'Draft', 'Problem is in draft mode, not yet published'),
    (2, 'Active', 'Problem is published and active for submissions'),
    (3, 'Archived', 'Problem is archived and no longer active')
ON CONFLICT (id) DO NOTHING;
