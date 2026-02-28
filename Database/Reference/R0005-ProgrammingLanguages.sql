
INSERT INTO programming_languages (id, name)
VALUES
    (1, 'JavaScript'),
    (2, 'TypeScript'),
    (3, 'Python')
ON CONFLICT (name) DO UPDATE
SET name = EXCLUDED.name;

WITH source(id, language, version, initial_code) AS (
    VALUES
    (1, 'JavaScript', 'Node.js 22.08.0', 'function solution() {

}'),
    (2, 'TypeScript', '5.6.2', 'function solution(): void {

}'),
    (3, 'Python', '3.14.0', 'def solution():
')
)
INSERT INTO programming_language_versions (id, programming_language_id, version, initial_code)
SELECT
    s.id,
    l.id,
    s.version,
    s.initial_code
FROM source s
JOIN programming_languages l
  ON l.name = s.language
ON CONFLICT (programming_language_id, version)
DO UPDATE SET
    initial_code = EXCLUDED.initial_code;