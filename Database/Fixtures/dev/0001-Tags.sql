INSERT INTO tags (value) VALUES
('Math'),
('String')
ON CONFLICT (value) DO NOTHING;