ALTER TABLE accounts
    ADD COLUMN IF NOT EXISTS previous_username VARCHAR(36),
    ADD COLUMN IF NOT EXISTS username_last_changed_at TIMESTAMP;