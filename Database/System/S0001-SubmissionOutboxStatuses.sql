INSERT INTO submission_outbox_statuses (id, name, description)
VALUES
    (1, 'Pending',    'Waiting to be processed'),
    (2, 'Processing', 'Currently being processed by worker'),
    (3, 'Completed',  'Successfully processed'),
    (4, 'Failed',     'Processing failed')
ON CONFLICT (id)
DO UPDATE
SET
    name = EXCLUDED.name,
    description = EXCLUDED.description
WHERE
    submission_outbox_statuses.name IS DISTINCT FROM EXCLUDED.name
    OR submission_outbox_statuses.description IS DISTINCT FROM EXCLUDED.description;