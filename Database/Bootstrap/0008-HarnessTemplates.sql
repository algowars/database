-- =============================================================================
-- Bootstrap: Harness Templates
-- Purpose: Define code execution templates for different languages
-- =============================================================================

INSERT INTO harness_templates (id, name, description, template)
VALUES
    (1, 'JavaScript Default', 'Default harness for JavaScript/Node.js', 
'const assert = require("assert");
const solution = require("./solution");

module.exports = function runTests(tests) {
    tests.forEach(test => {
        try {
            const result = solution(test.input);
            assert.strictEqual(result, test.expectedOutput);
            console.log("PASS: " + test.name);
        } catch (e) {
            console.log("FAIL: " + test.name);
        }
    });
};'
),
    (2, 'Python Default', 'Default harness for Python',
'import sys
sys.path.insert(0, "/tmp/submission")

from solution import solution

def run_tests(tests):
    for test in tests:
        try:
            result = solution(test["input"])
            assert result == test["expected_output"], f"Expected {test[''expected_output'']}, got {result}"
            print(f"PASS: {test[''name'']}")
        except Exception as e:
            print(f"FAIL: {test[''name'']}")
            print(f"Error: {e}")

if __name__ == "__main__":
    run_tests(tests)
')
ON CONFLICT (id) DO NOTHING;
