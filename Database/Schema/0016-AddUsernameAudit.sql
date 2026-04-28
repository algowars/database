ALTER TABLE accounts
    ADD COLUMN previous_username VARCHAR(36),
    ADD COLUMN username_last_changed_at TIMESTAMP;