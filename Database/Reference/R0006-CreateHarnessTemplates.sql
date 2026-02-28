INSERT INTO harness_templates (template)
VALUES
(
'{{USER_CODE}}

process.stdin.on("data", data => {
    const args = JSON.parse(data.toString());
    const result = {{FUNCTION_NAME}}(...args);
    console.log(result);
});'
),
(
'{{USER_CODE}}

import sys
import json

data = sys.stdin.read()
args = json.loads(data)
result = {{FUNCTION_NAME}}(*args)
print(result);'
)
ON CONFLICT (template) DO UPDATE
SET template = EXCLUDED.template;