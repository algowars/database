
-- Migrate version strings that no longer match available Judge0 versions
UPDATE programming_language_versions
SET version = '17.0.6'
WHERE programming_language_id = (SELECT id FROM programming_languages WHERE name = 'Java')
  AND version = '21.0.5';

UPDATE programming_language_versions
SET version = '1.23.5'
WHERE programming_language_id = (SELECT id FROM programming_languages WHERE name = 'Go')
  AND version = '1.23';

INSERT INTO programming_languages (id, name)
VALUES
    (1, 'JavaScript'),
    (2, 'TypeScript'),
    (3, 'Python'),
    (4, 'Java'),
    (5, 'C++'),
    (6, 'Go')
ON CONFLICT (name) DO UPDATE
SET name = EXCLUDED.name;

WITH source(id, language, version, initial_code) AS (
    VALUES
    (1, 'JavaScript', 'Node.js 22.08.0', 'function solution() {

}'),
    (2, 'TypeScript', '5.6.2', 'function solution(): void {

}'),
    (3, 'Python', '3.14.0', 'def solution():
'),
    (4, 'Java', '17.0.6', 'public class Solution {
    public static Object solution() {

    }
}'),
    (5, 'C++', '17', '#include <bits/stdc++.h>
using namespace std;

auto solution() {

}'),
    (6, 'Go', '1.23.5', 'package main

func solution() {

}')
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
