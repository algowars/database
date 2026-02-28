INSERT INTO harness_templates (id, name, template)
VALUES
(
1,'JavaScript/TypeScript Template','{{USER_CODE}}

process.stdin.on("data", data => {
    const args = JSON.parse(data.toString());
    const result = {{FUNCTION_NAME}}(...args);
    console.log(result);
});'
),
(
2,'Python Template','{{USER_CODE}}

import sys
import json

data = sys.stdin.read()
args = json.loads(data)
result = {{FUNCTION_NAME}}(*args)
print(result);'
)
ON CONFLICT (id) DO UPDATE
SET template = EXCLUDED.template;