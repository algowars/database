INSERT INTO problems (
    id, title, slug, question, difficulty, status_id, version, created_on, created_by_id
)
SELECT
    gen_random_uuid(),
    'Hello or Goodbye',
    'hello-or-goodbye',
    'Given an integer `n`, return `"hello"` if `n` is **even**, otherwise return `"goodbye"`.

**Example 1:**

> **Input**: `n = 3`
> **Output**: `"goodbye"`

**Example 2:**

> **Input**: `n = 10`
> **Output**: `"hello"`

**Constraints:**

- `-10^9 <= n <= 10^9`
',
    500,
    ps.id,
    1,
    NOW(),
    NULL
FROM problem_statuses ps
WHERE ps.name = 'Published'
ON CONFLICT (slug) DO NOTHING;

INSERT INTO problem_tags (problem_id, tag_id)
SELECT p.id, t.id
FROM problems p
JOIN tags t ON t.value IN ('Math', 'String')
WHERE p.slug = 'hello-or-goodbye'
ON CONFLICT DO NOTHING;