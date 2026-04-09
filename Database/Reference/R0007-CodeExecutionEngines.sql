INSERT INTO code_execution_engines (id, name, is_active)
VALUES (1, 'judge0', TRUE)
ON CONFLICT (name) DO UPDATE
SET
    is_active = EXCLUDED.is_active
WHERE
    code_execution_engines.is_active IS DISTINCT FROM EXCLUDED.is_active;

WITH source (language, version, engine_name, engine_language_id, engine_language_name) AS (
    VALUES
        ('JavaScript', 'Node.js 22.08.0', 'judge0', 63, 'JavaScript (Node.js 12.14.0)'),
        ('TypeScript', '5.6.2',           'judge0', 74, 'TypeScript (5.6.2)'),
        ('Python',     '3.14.0',          'judge0', 71, 'Python (3.8.1)')
)
INSERT INTO language_version_engine_mappings
    (programming_language_version_id, engine_id, engine_language_id, engine_language_name)
SELECT
    plv.id,
    e.id,
    s.engine_language_id,
    s.engine_language_name
FROM source s
JOIN programming_languages pl
    ON pl.name = s.language
JOIN programming_language_versions plv
    ON plv.programming_language_id = pl.id
    AND plv.version = s.version
JOIN code_execution_engines e
    ON e.name = s.engine_name
ON CONFLICT (programming_language_version_id, engine_id) DO UPDATE
SET
    engine_language_id   = EXCLUDED.engine_language_id,
    engine_language_name = EXCLUDED.engine_language_name
WHERE
    language_version_engine_mappings.engine_language_id   IS DISTINCT FROM EXCLUDED.engine_language_id
    OR language_version_engine_mappings.engine_language_name IS DISTINCT FROM EXCLUDED.engine_language_name;