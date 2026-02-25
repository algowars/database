INSERT INTO accounts (id, username, sub, created_on)
VALUES
    ('5cb236f2-182e-4312-8f7f-d1c4203c2385', 'system', 'google-oauth2|115106906757670590454', NOW())
ON CONFLICT (id) DO UPDATE
SET
    username = EXCLUDED.username,
    sub = EXCLUDED.sub;