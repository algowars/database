INSERT INTO test_suite_types (id, name, description)
VALUES
    (1, 'Public', 'Visible test suite for evaluation'),
    (2, 'Hidden', 'Hidden test suite for scoring')
ON CONFLICT (id)
DO UPDATE
SET
    name = EXCLUDED.name,
    description = EXCLUDED.description
WHERE
    test_suite_types.name IS DISTINCT FROM EXCLUDED.name
    OR test_suite_types.description IS DISTINCT FROM EXCLUDED.description;