-- =============================================================================
-- Dev Fixture: Sample Accounts
-- Purpose: Create test user accounts for development
-- =============================================================================

INSERT INTO accounts (id, username, sub, image_url)
VALUES
    ('550e8400-e29b-41d4-a716-446655440001'::uuid, 'john_doe', 'auth0|google|123456', 'https://i.pravatar.cc/150?img=1'),
    ('550e8400-e29b-41d4-a716-446655440002'::uuid, 'jane_smith', 'auth0|google|234567', 'https://i.pravatar.cc/150?img=2'),
    ('550e8400-e29b-41d4-a716-446655440003'::uuid, 'test_user', 'auth0|google|345678', 'https://i.pravatar.cc/150?img=3'),
    ('550e8400-e29b-41d4-a716-446655440004'::uuid, 'demo_user', 'auth0|github|456789', 'https://i.pravatar.cc/150?img=4')
ON CONFLICT (sub) DO NOTHING;
