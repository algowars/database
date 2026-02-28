CREATE TABLE submission_outbox_statuses (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    created_on TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE submission_outbox_types (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description VARCHAR(500),
    created_on TIMESTAMPTZ NOT NULL DEFAULT now()
);

CREATE TABLE submission_outbox (
    id UUID PRIMARY KEY,
    submission_id UUID NOT NULL,
    submission_outbox_type_id INT NOT NULL,
    submission_outbox_status_id INT NOT NULL,
    attempt_count INT NOT NULL DEFAULT 0,
    next_attempt_on TIMESTAMPTZ,
    last_error TEXT,
    created_on TIMESTAMPTZ NOT NULL DEFAULT now(),
    process_on TIMESTAMPTZ,
    finalized_on TIMESTAMPTZ,

    CONSTRAINT fk_submission_outbox_submission
        FOREIGN KEY (submission_id)
        REFERENCES submissions(id)
        ON DELETE CASCADE,

    CONSTRAINT fk_submission_outbox_type
        FOREIGN KEY (submission_outbox_type_id)
        REFERENCES submission_outbox_types(id),

    CONSTRAINT fk_submission_outbox_status
        FOREIGN KEY (submission_outbox_status_id)
        REFERENCES submission_outbox_statuses(id)
);