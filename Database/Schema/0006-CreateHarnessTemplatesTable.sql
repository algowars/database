CREATE TABLE IF NOT EXISTS harness_templates (
    id                 INT PRIMARY KEY,
    name               VARCHAR(100) NOT NULL,
    description        VARCHAR(200) NULL,
    template           TEXT NOT NULL
);