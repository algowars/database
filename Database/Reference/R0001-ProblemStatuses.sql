INSERT INTO problem_statuses (id, name, description, created_on)
VALUES
    (1, 'Draft', 'Problem is being authored', NOW()),
    (2, 'Pending', 'Problem is pending to be published', NOW()),
    (3, 'Published', 'Problem is published and visible', NOW()),
    (4, 'Archived', 'Problem is archived', NOW())
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;