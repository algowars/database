-- =============================================================================
-- Bootstrap: Code Execution Engines
-- Purpose: Define available code execution engines/judges
-- =============================================================================

INSERT INTO code_execution_engines (id, name, is_active)
VALUES
    (1, 'Judge0', true),
    (2, 'Sphere Engine', false),
    (3, 'HackerEarth CodeChef', false)
ON CONFLICT (id) DO NOTHING;
