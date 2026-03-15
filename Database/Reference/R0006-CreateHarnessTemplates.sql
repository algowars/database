INSERT INTO harness_templates (id, name, template)
VALUES
(
1,'JavaScript/TypeScript Template','{{USER_CODE}}

process.stdin.on("data", data => {
    const parsed = JSON.parse(data.toString().trim());
    const args = Array.isArray(parsed) ? parsed : [parsed];
    const result = {{FUNCTION_NAME}}(...args);
    process.stdout.write(String(result).trim());
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