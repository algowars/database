INSERT INTO test_cases_inputs_value_types (name)
VALUES ('integer')
ON CONFLICT (name) DO NOTHING;

WITH value_type AS (
    SELECT id FROM test_cases_inputs_value_types WHERE name = 'integer'
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
INSERT INTO test_cases_expected_outputs (test_case_id, value, output_type)
SELECT hidden_tc0.id, 'hello', 'string' FROM hidden_tc0
UNION ALL
SELECT hidden_tc_neg1.id, 'goodbye', 'string' FROM hidden_tc_neg1
UNION ALL
SELECT hidden_tc_neg10.id, 'hello', 'string' FROM hidden_tc_neg10
UNION ALL
SELECT hidden_tc_101.id, 'goodbye', 'string' FROM hidden_tc_101
UNION ALL
SELECT hidden_tc_100.id, 'hello', 'string' FROM hidden_tc_100
UNION ALL
SELECT hidden_tc_big.id, 'goodbye', 'string' FROM hidden_tc_big
UNION ALL
SELECT hidden_tc_bigneg.id, 'hello', 'string' FROM hidden_tc_bigneg;