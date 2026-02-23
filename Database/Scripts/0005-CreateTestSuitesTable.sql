CREATE TABLE IF NOT EXISTS test_suite_types (
    id          PRIMARY KEY,
    name        VARCHAR(50) NOT NULL,
    description VARCHAR(100) NOT NULL,
    CONSTRAINT uq_test_suite_types_name UNIQUE (name)
);

CREATE TABLE IF NOT EXISTS test_suites (
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(100) NOT NULL,
    description         VARCHAR(100) NULL,
    test_suite_type_id  INT NOT NULL,
    CONSTRAINT fk_test_suites_test_suite_type_id
        FOREIGN KEY (test_suite_type_id) REFERENCES test_suite_types(id) ON DELETE CASCADE,
);

CREATE TABLE IF NOT EXISTS test_cases_inputs_value_types (
    id PRIMARY KEY,
    name VARCHAR(50) NOT NULL
)

CREATE TABLE IF NOT EXISTS test_cases_inputs (
    id SERIAL PRIMARY KEY,
    value TEXT NOT NULL,
    test_cases_inputs_value_type_id INT NOT NULL,

    CONSTRAINT fk_test_cases_inputs_test_cases_inputs_value_type_id
        FOREIGN KEY (test_cases_inputs_value_type_id)
            REFERENCES test_cases_inputs_value_types(id)
            ON DELETE RESTRICT,
)

CREATE TABLE IF NOT EXISTS test_cases (
    id SERIAL PRIMARY KEY,
    test_suite_id INT NOT NULL,
);