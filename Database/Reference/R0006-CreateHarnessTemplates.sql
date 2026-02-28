INSERT INTO harness_templates (id, template)
VALUES
(
1,'{{USER_CODE}}

process.stdin.on("data", data => {
    const args = JSON.parse(data.toString());
    const result = {{FUNCTION_NAME}}(...args);
    console.log(result);
});'
),
(
2,'{{USER_CODE}}

import sys
import json

data = sys.stdin.read()
args = json.loads(data)
result = {{FUNCTION_NAME}}(*args)
print(result);'
)
ON CONFLICT (template) DO UPDATE
SET template = EXCLUDED.template;