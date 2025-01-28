# README

- [Version Control \& Git Tools](#version-control--git-tools)
  - [Repository Management](#repository-management)
    - [`git-fixup-prep`](#git-fixup-prep)
  - [AI-Assisted Git Tools](#ai-assisted-git-tools)
    - [`git-ai-commit`](#git-ai-commit)

This repository contains various utility scripts, primarily in Bash and Python, to assist with git.

## Version Control & Git Tools

### Repository Management

#### `git-fixup-prep`
Prepares commits for interactive rebase fixup by creating separate commits for each modified file, with commit messages that reference their previous commits.

Usage:
```bash
git-fixup-prep [-n|--dry-run]
```

Workflow:
1. Make changes to multiple files
2. Run `git-fixup-prep` to create separate commits
3. Run `git rebase -i HEAD~N` where N includes all new commits
4. Move each commit next to its referenced commit and mark it as 'fixup'

Options:
- `-n, --dry-run`: Show what would be done without making changes

### AI-Assisted Git Tools

#### `git-ai-commit`
Generates commit messages based on changes using AI assistance. Designed to streamline commit message creation and ensure consistent descriptions.

```bash
git-ai-commit # Analyzes current changes and suggests commit message
```
