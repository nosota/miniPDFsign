# Auto Commit

Automatically commit all staged and unstaged changes with an AI-generated commit message.

## Instructions

1. Run `git status` to see all changes
2. Run `git diff` to see the actual code changes (both staged and unstaged)
3. Analyze the changes and generate a concise commit message following Conventional Commits format:
   - `feat:` for new features
   - `fix:` for bug fixes
   - `refactor:` for code refactoring
   - `docs:` for documentation
   - `style:` for formatting changes
   - `test:` for tests
   - `chore:` for maintenance tasks
4. Stage all changes with `git add -A`
5. Commit with the generated message, including co-author:
   ```
   git commit -m "$(cat <<'EOF'
   <type>: <short description>

   Co-Authored-By: Claude <noreply@anthropic.com>
   EOF
   )"
   ```
6. Show the result of `git log -1` to confirm the commit

## Rules

- Keep commit messages under 72 characters for the first line
- Focus on WHAT changed and WHY, not HOW
- Use imperative mood ("add feature" not "added feature")
- Do NOT push to remote unless explicitly requested