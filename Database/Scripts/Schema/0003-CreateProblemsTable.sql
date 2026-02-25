CREATE TABLE IF NOT EXISTS problem_statuses (
    id                  INT PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    description         VARCHAR(100) NULL,
    created_on          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_id       UUID NULL,
    last_modified_on    TIMESTAMPTZ NULL,
    last_modified_by_id UUID NULL,
    deleted_on          TIMESTAMPTZ NULL,

    CONSTRAINT uq_problem_statuses_name UNIQUE (name),
    CONSTRAINT fk_problem_statuses_created_by
        FOREIGN KEY (created_by_id) REFERENCES accounts(id) ON DELETE SET NULL,
    CONSTRAINT fk_problem_statuses_last_modified_by
        FOREIGN KEY (last_modified_by_id) REFERENCES accounts(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS problems (
    id                  UUID PRIMARY KEY,
    title               VARCHAR(100) NOT NULL,
    slug                VARCHAR(150) NOT NULL,
    question            TEXT NOT NULL,
    difficulty          INT NOT NULL,
    status_id           INT NOT NULL DEFAULT 1,
    version             INT NOT NULL DEFAULT 1,
    created_on          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_id       UUID  NULL,
    last_modified_on    TIMESTAMPTZ NULL,
    last_modified_by_id UUID NULL,
    deleted_on          TIMESTAMPTZ NULL,

    CONSTRAINT uq_problems_slug UNIQUE (slug),

    CONSTRAINT fk_problems_status
        FOREIGN KEY (status_id)
            REFERENCES problem_statuses(id),

    CONSTRAINT fk_problems_created_by_id
        FOREIGN KEY (created_by_id)
            REFERENCES accounts(id)
            ON DELETE SET NULL,

    CONSTRAINT fk_problems_last_modified_by_id
        FOREIGN KEY (last_modified_by_id)
            REFERENCES accounts(id)
            ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS problem_tags (
    problem_id  UUID NOT NULL,
    tag_id      INT NOT NULL,
    PRIMARY KEY (problem_id, tag_id),
    CONSTRAINT fk_problem_tags_problem
        FOREIGN KEY (problem_id) REFERENCES problems(id) ON DELETE CASCADE,
    CONSTRAINT fk_problem_tags_tag
        FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);