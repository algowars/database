INSERT INTO programming_languages (name)
VALUES
    ('JavaScript'),
    ('TypeScript'),
    ('Python')
ON CONFLICT (name) DO UPDATE
SET name = EXCLUDED.name;



WITH source(language, version, initial_code) AS (
    VALUES
    ('JavaScript', 'Node.js 22.08.0', 'function solution() {

}'),
    ('TypeScript', '5.6.2', 'function solution(): void {

}'),
    ('Python', '3.14.0', 'def solution():
')
)
INSERT INTO programming_language_versions (programming_language_id, version, initial_code)
SELECT
    l.id,
    s.version,
    s.initial_code
FROM source s
JOIN programming_languages l
  ON l.name = s.language
ON CONFLICT (programming_language_id, version)
DO UPDATE SET
    initial_code = EXCLUDED.initial_code;