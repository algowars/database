CREATE TABLE IF NOT EXISTS accounts (
    id UUID             PRIMARY KEY,
    username            VARCHAR(36) NOT NULL,
    sub                 VARCHAR(255) NOT NULL,
    image_url           VARCHAR(300),
    is_archived         BOOLEAN NOT NULL DEFAULT FALSE,
    created_on          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_modified_on    TIMESTAMPTZ NULL,
    last_modified_by_ID UUID NULL,
    deleted_on          TIMESTAMPTZ NULL,

    CONSTRAINT uq_accounts_username UNIQUE (username),
    CONSTRAINT uq_accounts_sub  UNIQUE (sub),
    CONSTRAINT fk_accounts_last_modified_by FOREIGN KEY (last_modified_by_ID)
        REFERENCES accounts(id) ON DELETE SET NULL
);