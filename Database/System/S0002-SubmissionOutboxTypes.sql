DELETE FROM submission_outbox_types
WHERE id NOT IN (1, 2, 3, 4, 5);

INSERT INTO submission_outbox_types (id, name, description)
VALUES
    (1, 'Initialized',        'Submission created and queued'),
    (2, 'ExecuteSubmission',  'Send submission to Judge0 for execution'),
    (3, 'PollExecution',      'Poll Judge0 for execution result'),
    (4, 'EvaluateSubmission', 'Evaluate the result of the submission'),
    (5, 'PollEvaluation',     'Poll for the evaluation result')
ON CONFLICT (id)
DO UPDATE
SET
    name        = EXCLUDED.name,
    description = EXCLUDED.description
WHERE
    submission_outbox_types.name        IS DISTINCT FROM EXCLUDED.name
    OR submission_outbox_types.description IS DISTINCT FROM EXCLUDED.description;