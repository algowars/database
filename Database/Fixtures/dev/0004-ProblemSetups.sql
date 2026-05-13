INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    1,
    1,
    'function solution(n) {
  // Your code here
}
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'JavaScript')
                  AND plv.version = 'Node.js 22.08.0'
WHERE p.slug = 'hello-or-goodbye'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    1,
    1,
    'function solution(n: number): string {
  // Your code here
}
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'TypeScript')
                  AND plv.version = '5.6.2'
WHERE p.slug = 'hello-or-goodbye'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    2,
    1,
    'def solution(n: int) -> str:
    # Your code here
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'Python')
                  AND plv.version = '3.14.0'
WHERE p.slug = 'hello-or-goodbye'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setup_test_suites (problem_setup_id, test_suite_id)
SELECT ps.id, ts.id
FROM problem_setups ps
         JOIN problems p ON p.id = ps.problem_id
         JOIN programming_language_versions plv ON plv.id = ps.programming_language_version_id
         JOIN programming_languages pl ON pl.id = plv.programming_language_id
         JOIN test_suites ts ON ts.name = 'Hello or Goodbye hidden tests'
WHERE p.slug = 'hello-or-goodbye'
  AND pl.name = 'JavaScript'
  AND plv.version = 'Node.js 22.08.0'
ON CONFLICT (problem_setup_id, test_suite_id) DO NOTHING;

INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    1,
    1,
    'function solution(n) {
  // Your code here
}
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'JavaScript')
                  AND plv.version = 'Node.js 22.08.0'
WHERE p.slug = 'fizz-or-buzz'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    1,
    1,
    'function solution(n: number): string {
  // Your code here
}
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'TypeScript')
                  AND plv.version = '5.6.2'
WHERE p.slug = 'fizz-or-buzz'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    2,
    1,
    'def solution(n: int) -> str:
    # Your code here
',
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'Python')
                  AND plv.version = '3.14.0'
WHERE p.slug = 'fizz-or-buzz'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;

INSERT INTO problem_setup_test_suites (problem_setup_id, test_suite_id)
SELECT ps.id, ts.id
FROM problem_setups ps
         JOIN problems p ON p.id = ps.problem_id
         JOIN programming_language_versions plv ON plv.id = ps.programming_language_version_id
         JOIN programming_languages pl ON pl.id = plv.programming_language_id
         JOIN test_suites ts ON ts.name = 'Fizz or Buzz hidden tests'
WHERE p.slug = 'fizz-or-buzz'
  AND pl.name = 'JavaScript'
  AND plv.version = 'Node.js 22.08.0'
ON CONFLICT (problem_setup_id, test_suite_id) DO NOTHING;