DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM test_suites WHERE name = 'Hello or Goodbye hidden tests'
    ) THEN

        INSERT INTO test_cases_inputs_value_types (name)
        VALUES ('integer')
        ON CONFLICT (name) DO NOTHING;

        WITH value_type AS (
            SELECT id FROM test_cases_inputs_value_types WHERE name = 'integer'
        ),
        output_value_type AS (
            SELECT id FROM test_cases_output_value_types WHERE name = 'String'
        ),
        suite_type_hidden AS (
            SELECT id FROM test_suite_types WHERE name = 'Hidden'
        ),
        hidden_suite AS (
            INSERT INTO test_suites (name, description, test_suite_type_id)
            SELECT 'Hello or Goodbye hidden tests', 'Hidden edge cases for Hello or Goodbye', suite_type_hidden.id
            FROM suite_type_hidden
            RETURNING id
        ),
        hidden_tc0 AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Edge Zero', 'Input: n = 0' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_neg1 AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Edge Negative One', 'Input: n = -1' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_neg10 AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Edge Negative Ten', 'Input: n = -10' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_101 AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Large Odd', 'Input: n = 101' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_100 AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Large Even', 'Input: n = 100' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_big AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Big Odd', 'Input: n = 99999999' FROM hidden_suite
            RETURNING id
        ),
        hidden_tc_bigneg AS (
            INSERT INTO test_cases (test_suite_id, name, description)
            SELECT hidden_suite.id, 'Big Negative Even', 'Input: n = -1000000000' FROM hidden_suite
            RETURNING id
        ),
        inputs AS (
            INSERT INTO test_cases_inputs (test_case_id, value, test_cases_inputs_value_type_id)
            SELECT hidden_tc0.id, '0', value_type.id FROM hidden_tc0, value_type
            UNION ALL
            SELECT hidden_tc_neg1.id, '-1', value_type.id FROM hidden_tc_neg1, value_type
            UNION ALL
            SELECT hidden_tc_neg10.id, '-10', value_type.id FROM hidden_tc_neg10, value_type
            UNION ALL
            SELECT hidden_tc_101.id, '101', value_type.id FROM hidden_tc_101, value_type
            UNION ALL
            SELECT hidden_tc_100.id, '100', value_type.id FROM hidden_tc_100, value_type
            UNION ALL
            SELECT hidden_tc_big.id, '99999999', value_type.id FROM hidden_tc_big, value_type
            UNION ALL
            SELECT hidden_tc_bigneg.id, '-1000000000', value_type.id FROM hidden_tc_bigneg, value_type
            RETURNING test_case_id
        )
        INSERT INTO test_cases_expected_outputs (test_case_id, value, output_value_type_id)
        SELECT hidden_tc0.id, 'hello', output_value_type.id FROM hidden_tc0, output_value_type
        UNION ALL
        SELECT hidden_tc_neg1.id, 'goodbye', output_value_type.id FROM hidden_tc_neg1, output_value_type
        UNION ALL
        SELECT hidden_tc_neg10.id, 'hello', output_value_type.id FROM hidden_tc_neg10, output_value_type
        UNION ALL
        SELECT hidden_tc_101.id, 'goodbye', output_value_type.id FROM hidden_tc_101, output_value_type
        UNION ALL
        SELECT hidden_tc_100.id, 'hello', output_value_type.id FROM hidden_tc_100, output_value_type
        UNION ALL
        SELECT hidden_tc_big.id, 'goodbye', output_value_type.id FROM hidden_tc_big, output_value_type
        UNION ALL
        SELECT hidden_tc_bigneg.id, 'hello', output_value_type.id FROM hidden_tc_bigneg, output_value_type;

    END IF;
END;
$$;