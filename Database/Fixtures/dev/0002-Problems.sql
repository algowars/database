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

INSERT INTO problems (
    id, title, slug, question, difficulty, status_id, version, created_on, created_by_id
)
SELECT
    gen_random_uuid(),
    'Fizz or Buzz',
    'fizz-or-buzz',
    'Given an integer `n`, return `"fizzbuzz"` if `n` is divisible by **both** 3 and 5, `"fizz"` if divisible by only 3, `"buzz"` if divisible by only 5, or `n` as a string if it is not divisible by 3 or 5.

**Example 1:**

> **Input**: `n = 3`
> **Output**: `"fizz"`

**Example 2:**

> **Input**: `n = 5`
> **Output**: `"buzz"`

**Example 3:**

> **Input**: `n = 15`
> **Output**: `"fizzbuzz"`

**Example 4:**

> **Input**: `n = 7`
> **Output**: `"7"`

**Constraints:**

- `-10^9 <= n <= 10^9`
',
    1000,
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
WHERE p.slug = 'fizz-or-buzz'
ON CONFLICT DO NOTHING;