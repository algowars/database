CREATE TABLE IF NOT EXISTS problem_setups (
    id                          SERIAL PRIMARY KEY,
    problem_id                  uuid                 NOT NULL,
    programming_language_version_id integer          NOT NULL,
    harness_template_id         integer              NOT NULL,
    version                     integer              NOT NULL,
    initial_code                text                 NOT NULL,
    function_name               text                 NOT NULL,
    created_on                  timestamptz          NOT NULL DEFAULT now(),
    created_by_id               uuid                 NULL,
    last_modified_on            timestamptz          NULL,
    last_modified_by_id         uuid                 NULL,
    deleted_on                  timestamptz          NULL,

    CONSTRAINT ux_problem_setups_problem_version
        UNIQUE (problem_id, programming_language_version_id),

    CONSTRAINT fk_problem_setups_problem_id
        FOREIGN KEY (problem_id)
        REFERENCES problems(id)
        ON DELETE CASCADE
        ON UPDATE NO ACTION,

    CONSTRAINT fk_problem_setups_programming_language_version_id
        FOREIGN KEY (programming_language_version_id)
        REFERENCES programming_language_versions(id)
        ON DELETE RESTRICT
        ON UPDATE NO ACTION,

    CONSTRAINT fk_problem_setups_harness_template_id
        FOREIGN KEY (harness_template_id)
        REFERENCES harness_templates(id)
        ON DELETE RESTRICT
        ON UPDATE NO ACTION,

    CONSTRAINT fk_problem_setups_created_by_id
        FOREIGN KEY (created_by_id)
        REFERENCES accounts(id)
        ON DELETE SET NULL
        ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS problem_setup_test_suites (
    problem_setup_id integer NOT NULL
    REFERENCES problem_setups(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    test_suite_id integer NOT NULL
    REFERENCES test_suites(id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,

    CONSTRAINT pk_problem_setup_test_suites PRIMARY KEY (problem_setup_id, test_suite_id)
);