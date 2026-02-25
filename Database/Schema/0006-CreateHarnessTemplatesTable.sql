CREATE TABLE IF NOT EXISTS harness_templates (
    id                 PRIMARY KEY,
    name               VARCHAR(100) NOT NULL,
    description        VARCHAR(200) NULL,
    template           TEXT NOT NULL,
    CONSTRAINT uq_harness_templates_name_language UNIQUE (name, language)
);