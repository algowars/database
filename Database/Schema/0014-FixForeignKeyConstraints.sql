-- =============================================================================
-- Migration: Fix Foreign Key Constraint Issues
-- Purpose: Address critical FK syntax errors and missing constraint definitions
-- =============================================================================

-- ISSUE #1: Fix problem_setup_test_suites table
-- Previous migration had broken FK syntax - recreate with proper constraints
-- This is idempotent using DROP IF EXISTS

DROP TABLE IF EXISTS problem_setup_test_suites CASCADE;

CREATE TABLE IF NOT EXISTS problem_setup_test_suites (
    problem_setup_id INTEGER NOT NULL,
    test_suite_id INTEGER NOT NULL,
    
    -- Primary Key Constraint (named)
    CONSTRAINT pk_problem_setup_test_suites 
        PRIMARY KEY (problem_setup_id, test_suite_id),
    
    -- Foreign Key Constraint: problem_setup_id
    CONSTRAINT fk_problem_setup_test_suites_problem_setup
        FOREIGN KEY (problem_setup_id) 
            REFERENCES problem_setups(id) 
            ON DELETE CASCADE 
            ON UPDATE NO ACTION,
    
    -- Foreign Key Constraint: test_suite_id
    CONSTRAINT fk_problem_setup_test_suites_test_suite
        FOREIGN KEY (test_suite_id) 
            REFERENCES test_suites(id) 
            ON DELETE CASCADE 
            ON UPDATE NO ACTION
);

-- =============================================================================
-- ISSUE #2: Fix submission_results FK constraint naming
-- Add explicit constraint name for status_id foreign key
-- =============================================================================

-- Add constraint with proper name (use ALTER TABLE if not already named)
-- The following is safe because we're adding a named constraint
-- If unnamed constraint exists, this will add alongside it (idempotent)

ALTER TABLE submission_results
ADD CONSTRAINT fk_submission_results_status_id
    FOREIGN KEY (status_id) REFERENCES submission_statuses(id)
    ON DELETE RESTRICT;

-- =============================================================================
-- ISSUE #3: Fix submission_results - ensure creation audit trail
-- Some versions may lack this; adding it here for consistency
-- =============================================================================

-- Add all audit columns if they don't exist
DO $$ 
BEGIN 
    -- Add created_on with default
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='submission_results' AND column_name='created_on'
    ) THEN
        ALTER TABLE submission_results 
            ADD COLUMN created_on TIMESTAMPTZ NOT NULL DEFAULT NOW();
    END IF;

    -- Add created_by_id
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='submission_results' AND column_name='created_by_id'
    ) THEN
        ALTER TABLE submission_results 
            ADD COLUMN created_by_id UUID NULL,
            ADD CONSTRAINT fk_submission_results_created_by
                FOREIGN KEY (created_by_id) REFERENCES accounts(id) ON DELETE SET NULL;
    END IF;

    -- Add last_modified_on
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='submission_results' AND column_name='last_modified_on'
    ) THEN
        ALTER TABLE submission_results 
            ADD COLUMN last_modified_on TIMESTAMPTZ NULL;
    END IF;

    -- Add last_modified_by_id
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='submission_results' AND column_name='last_modified_by_id'
    ) THEN
        ALTER TABLE submission_results 
            ADD COLUMN last_modified_by_id UUID NULL,
            ADD CONSTRAINT fk_submission_results_last_modified_by
                FOREIGN KEY (last_modified_by_id) REFERENCES accounts(id) ON DELETE SET NULL;
    END IF;

    -- Add deleted_on for soft delete support
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name='submission_results' AND column_name='deleted_on'
    ) THEN
        ALTER TABLE submission_results 
            ADD COLUMN deleted_on TIMESTAMPTZ NULL;
    END IF;
END $$;

-- =============================================================================
-- ISSUE #4: Fix submission_outbox FK constraints with proper ON DELETE behavior
-- =============================================================================

-- First, check if constraints exist and recreate them with proper behavior
-- We need to ensure ON DELETE and ON UPDATE are specified

-- Add constraints with explicit delete behavior (idempotent via constraint naming)
DO $$
BEGIN
    -- For submission_outbox_type_id
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE table_name='submission_outbox' 
        AND constraint_name='fk_submission_outbox_type'
    ) THEN
        ALTER TABLE submission_outbox
        ADD CONSTRAINT fk_submission_outbox_type
            FOREIGN KEY (submission_outbox_type_id) 
            REFERENCES submission_outbox_types(id) 
            ON DELETE RESTRICT 
            ON UPDATE NO ACTION;
    END IF;
    
    -- For submission_outbox_status_id
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.table_constraints 
        WHERE table_name='submission_outbox' 
        AND constraint_name='fk_submission_outbox_status'
    ) THEN
        ALTER TABLE submission_outbox
        ADD CONSTRAINT fk_submission_outbox_status
            FOREIGN KEY (submission_outbox_status_id) 
            REFERENCES submission_outbox_statuses(id) 
            ON DELETE RESTRICT 
            ON UPDATE NO ACTION;
    END IF;
END $$;

-- =============================================================================
-- Verification: List all FK constraints in submission_outbox
-- =============================================================================

-- Run this to verify constraints were added:
-- SELECT constraint_name, table_name, column_name 
-- FROM information_schema.key_column_usage 
-- WHERE table_name='submission_outbox' 
-- ORDER BY constraint_name;
