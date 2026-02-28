WITH type_ids AS (
    SELECT
        MAX(id) FILTER (WHERE name = 'Answer')    AS answer_id,
        MAX(id) FILTER (WHERE name = 'Execution') AS execution_id
    FROM submission_status_types
)
INSERT INTO submission_statuses (id, name, description, status_type_id)
SELECT
    v.id,
    v.name,
    v.description,
    CASE
        WHEN v.type_key = 'answer' THEN type_ids.answer_id
        ELSE type_ids.execution_id
    END AS status_type_id
FROM (
    VALUES
    (1, 'Accepted', 'The submission passed all test cases.', 'answer'),
    (2, 'WrongAnswer', 'The submission failed one or more test cases.', 'answer'),
    (3, 'InQueue', 'Submission is waiting to be processed.', 'execution'),
    (4, 'Processing', 'Submission is currently being executed.', 'execution'),
    (5, 'TimeLimitExceeded', 'The submission exceeded the allowed execution time.', 'execution'),
    (6, 'CompilationError', 'The submission failed to compile.', 'execution'),
    (7, 'RuntimeErrorSigSegv', 'Segmentation fault during execution.', 'execution'),
    (8, 'RuntimeErrorSigXfsz', 'Exceeded file size limit during execution.', 'execution'),
    (9, 'RuntimeErrorSigFpe', 'Floating point exception during execution.', 'execution'),
    (10, 'RuntimeErrorSigAbrt', 'Program aborted unexpectedly.', 'execution'),
    (11, 'RuntimeErrorNzec', 'Non-zero exit code from the program.', 'execution'),
    (12, 'RuntimeErrorOther', 'Other runtime errors.', 'execution'),
    (13, 'InternalError', 'An internal judge error occurred.', 'execution'),
    (14, 'ExecFormatError', 'The executable format is invalid.', 'execution')
) AS v(id, name, description, type_key), type_ids
ON CONFLICT (id)
DO UPDATE
SET
    name = EXCLUDED.name,
    description = EXCLUDED.description,
    status_type_id = EXCLUDED.status_type_id
WHERE
    submission_statuses.name IS DISTINCT FROM EXCLUDED.name
    OR submission_statuses.description IS DISTINCT FROM EXCLUDED.description
    OR submission_statuses.status_type_id IS DISTINCT FROM EXCLUDED.status_type_id;