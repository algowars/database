INSERT INTO code_execution_engines (id, name, is_active)
VALUES (1, 'judge0', TRUE)
ON CONFLICT (name) DO UPDATE
SET
    is_active = EXCLUDED.is_active
WHERE
    code_execution_engines.is_active IS DISTINCT FROM EXCLUDED.is_active;

WITH source (language, version, engine_name, engine_language_id, engine_language_name) AS (
    VALUES
        ('JavaScript', 'Node.js 22.08.0', 'judge0', 102, 'JavaScript (Node.js 22.08.0)'),
        ('TypeScript', '5.6.2',           'judge0', 101, 'TypeScript (5.6.2)'),
        ('Python',     '3.14.0',          'judge0', 113, 'Python (3.14.0)'),
        ('Java',       '17.0.6',          'judge0', 91,  'Java (JDK 17.0.6)'),
        ('C++',        '17',              'judge0', 105, 'C++ (GCC 14.1.0)'),
        ('Go',         '1.23.5',          'judge0', 107, 'Go (1.23.5)')
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