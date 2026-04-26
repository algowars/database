-- =============================================================================
-- Bootstrap: Programming Languages
-- Purpose: Define available programming languages
-- =============================================================================

INSERT INTO programming_languages (id, name, is_archived)
VALUES
    (1, 'Python', false),
    (2, 'JavaScript', false),
    (3, 'TypeScript', false),
    (4, 'Java', false),
    (5, 'C++', false),
    (6, 'Go', false)
ON CONFLICT (id) DO NOTHING;
