INSERT INTO problem_setups (
    problem_id, programming_language_version_id, harness_template_id, version, initial_code, function_name, created_on, created_by_id
)
SELECT
    p.id,
    plv.id,
    1,
    1,
    plv.initial_code,
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
    plv.initial_code,
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
    plv.initial_code,
    'solution',
    NOW(),
    NULL
FROM problems p
         JOIN programming_language_versions plv
              ON plv.programming_language_id = (SELECT id FROM programming_languages WHERE name = 'Python')
                  AND plv.version = '3.14.0'
WHERE p.slug = 'hello-or-goodbye'
    ON CONFLICT (problem_id, programming_language_version_id) DO NOTHING;