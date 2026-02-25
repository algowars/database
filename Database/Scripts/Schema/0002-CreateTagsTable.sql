CREATE TABLE IF NOT EXISTS tags (
    id      SERIAL PRIMARY KEY,
    value   VARCHAR(50) NOT NULL,

    CONSTRAINT uq_tags_value UNIQUE (value)
);