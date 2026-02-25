INSERT INTO submission_status_types (id, name, description)
VALUES
    (1, 'Correct Answer', 'Represents the correctness of the submission'),
    (2, 'Incorrect Answer', 'Represents runtime, compilation, or internal execution errors')
ON CONFLICT (id)
DO UPDATE
SET
    name = EXCLUDED.name,
    description = EXCLUDED.description
WHERE
    submission_status_types.name IS DISTINCT FROM EXCLUDED.name
    OR submission_status_types.description IS DISTINCT FROM EXCLUDED.description;