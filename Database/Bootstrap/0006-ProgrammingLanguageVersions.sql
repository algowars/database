-- =============================================================================
-- Bootstrap: Programming Language Versions
-- Purpose: Define specific versions of programming languages
-- =============================================================================

INSERT INTO programming_language_versions (id, version, programming_language_id, initial_code)
VALUES
    (1, '3.14.0', 1, 'def solution(n: int) -> str:
    # Your code here
    pass
'),
    (2, 'Node.js 22.08.0', 2, 'function solution(n) {
  // Your code here
}
'),
    (3, '5.6.2', 3, 'function solution(n: number): string {
  // Your code here
}
'),
    (4, '21.0.5', 4, 'public class Solution {
    public String solution(int n) {
        // Your code here
        return "";
    }
}
'),
    (5, '17', 5, 'std::string solution(int n) {
    // Your code here
    return "";
}
'),
    (6, '1.23', 6, 'package main

func solution(n int) string {
    // Your code here
    return ""
}
')
ON CONFLICT (id) DO NOTHING;
