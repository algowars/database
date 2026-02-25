CREATE TABLE IF NOT EXISTS submission_status_types (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS submission_statuses (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    status_type_id INT REFERENCES submission_status_types(id)
);

CREATE TABLE IF NOT EXISTS submissions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    code TEXT NOT NULL,
    problem_setup_id INT NOT NULL REFERENCES problem_setups(id),
    created_on TIMESTAMPTZ NOT NULL DEFAULT now(),
    completed_at TIMESTAMPTZ NULL,
    created_by_id UUID NOT NULL REFERENCES accounts(id)
);

CREATE TABLE IF NOT EXISTS submission_results (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    submission_id UUID NOT NULL REFERENCES submissions(id) ON DELETE CASCADE,
    status_id INT NOT NULL REFERENCES submission_statuses(id),
    started_at TIMESTAMPTZ,
    finished_at TIMESTAMPTZ,
    stdout TEXT,
    stderr TEXT,
    runtime_ms INT,
    memory_kb INT
);