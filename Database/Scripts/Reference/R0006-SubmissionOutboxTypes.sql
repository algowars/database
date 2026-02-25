INSERT INTO submission_outbox_types (id, name, description)
VALUES
    (1, 'Initialized',       'Submission created and queued'),
    (2, 'ExecuteSubmission', 'Send submission to Judge0 for execution'),
    (3, 'PollJudge0Result',  'Poll Judge0 for execution result')
ON CONFLICT (id)
DO UPDATE
SET
    name = EXCLUDED.name,
    description = EXCLUDED.description
WHERE
    submission_outbox_types.name IS DISTINCT FROM EXCLUDED.name
    OR submission_outbox_types.description IS DISTINCT FROM EXCLUDED.description;