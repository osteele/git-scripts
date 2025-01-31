# README

- [Version Control \& Git Tools](#version-control--git-tools)
  - [Repository Management](#repository-management)
    - [`git-fixup-prep`](#git-fixup-prep)
    - [`git-reorder-fcommits`](#git-reorder-fcommits)
  - [AI-Assisted Git Tools](#ai-assisted-git-tools)
    - [`git-ai-commit`](#git-ai-commit)

This repository contains various utility scripts, primarily in Bash and Python, to assist with git.

## Version Control & Git Tools

### Repository Management

#### `git-fixup-prep`
Creates separate commits for each modified file, with commit messages that reference their previous commits. Part of a workflow with `git-reorder-fcommits` for efficiently managing related changes across multiple files.

Usage:
```bash
git-fixup-prep [-n|--dry-run]
```

Options:
- `-n, --dry-run`: Show what would be done without making changes

#### `git-reorder-fcommits`
Automatically reorders and optionally squashes fixup commits created by `git-fixup-prep`. This provides an automated alternative to manually reordering commits in an interactive rebase.

**Workflow**:
1. Make changes to multiple files
2. Run `git-fixup-prep` to create separate commits for each file
3. Run `git-reorder-fcommits` to automatically reorder (and optionally squash) the commits

**Usage**:
```bash
# Show proposed reordering without executing
git-reorder-fcommits --dry-run

# Reorder and mark fixups for squashing
git-reorder-fcommits --squash

# Only process recent commits
git-reorder-fcommits --since="2 days ago"
git-reorder-fcommits -n 10
```

**Options**:
- `--dry-run, -n`: Show proposed reordering without executing
- `--squash, -s`: Use 'squash' instead of 'pick' for fixup commits
- `--max-count, -n N`: Limit to processing the last N commits
- `--since DATE`: Process commits more recent than DATE (e.g. "2 days ago")

### AI-Assisted Git Tools

#### `git-ai-commit`
Generates commit messages based on changes using AI assistance. Designed to streamline commit message creation and ensure consistent descriptions.

```bash
git-ai-commit # Analyzes current changes and suggests commit message
```
