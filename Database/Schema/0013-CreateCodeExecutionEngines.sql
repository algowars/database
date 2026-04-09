CREATE TABLE IF NOT EXISTS code_execution_engines (
    id        SERIAL PRIMARY KEY,
    name      VARCHAR(50) NOT NULL UNIQUE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS language_version_engine_mappings (
    id                              SERIAL PRIMARY KEY,
    programming_language_version_id INT NOT NULL
        REFERENCES programming_language_versions(id) ON DELETE CASCADE,
    engine_id                       INT NOT NULL
        REFERENCES code_execution_engines(id) ON DELETE CASCADE,
    engine_language_id              INT NOT NULL,
    engine_language_name            VARCHAR(100) NULL,

    CONSTRAINT uq_lang_version_engine
        UNIQUE (programming_language_version_id, engine_id)
);

CREATE TABLE IF NOT EXISTS code_executions (
    id                   UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    submission_result_id UUID NOT NULL
        REFERENCES submission_results(id) ON DELETE CASCADE,
    engine_id            INT NOT NULL
        REFERENCES code_execution_engines(id),
    engine_token         UUID NULL,
    engine_language_id   INT NOT NULL,
    source_code          TEXT NOT NULL,
    stdin                TEXT NULL,
    expected_output      TEXT NULL,
    stdout               TEXT NULL,
    stderr               TEXT NULL,
    compile_output       TEXT NULL,
    status_id            INT NULL
        REFERENCES submission_statuses(id),
    runtime_ms           INT NULL,
    memory_kb            INT NULL,
    submitted_at         TIMESTAMPTZ NULL,
    finished_at          TIMESTAMPTZ NULL,
    created_on           TIMESTAMPTZ NOT NULL DEFAULT NOW()
);