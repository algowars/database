CREATE TABLE IF NOT EXISTS programming_languages (
    id                  INT PRIMARY KEY,
    name                VARCHAR(50) NOT NULL,
    is_archived         BOOLEAN NOT NULL DEFAULT FALSE,
    created_on          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_id       UUID NULL,
    last_modified_on    TIMESTAMPTZ NULL,
    last_modified_by_id UUID NULL,
    deleted_on          TIMESTAMPTZ NULL,

    CONSTRAINT uq_programming_languages_name UNIQUE (name),
    CONSTRAINT fk_programming_languages_created_by
        FOREIGN KEY (created_by_id) REFERENCES accounts(id) ON DELETE SET NULL,
    CONSTRAINT fk_programming_languages_last_modified_by
        FOREIGN KEY (last_modified_by_id) REFERENCES accounts(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS programming_language_versions (
    id                      INT PRIMARY KEY,
    version                 VARCHAR(20) NOT NULL,
    programming_language_id INT NOT NULL,
    created_on              TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by_id           UUID NULL,
    last_modified_on        TIMESTAMPTZ NULL,
    last_modified_by_id     UUID NULL,
    deleted_on              TIMESTAMPTZ NULL,
    initial_code            TEXT NULL,

    CONSTRAINT fk_language_versions_language
        FOREIGN KEY (programming_language_id)
            REFERENCES programming_languages(id)
            ON DELETE RESTRICT,

    CONSTRAINT uq_language_versions_language_version
        UNIQUE (programming_language_id, version),

    CONSTRAINT fk_language_versions_created_by
        FOREIGN KEY (created_by_id) REFERENCES accounts(id) ON DELETE SET NULL,
    CONSTRAINT fk_language_versions_last_modified_by
        FOREIGN KEY (last_modified_by_id) REFERENCES accounts(id) ON DELETE SET NULL
);