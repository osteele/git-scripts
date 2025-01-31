# README

- [Version Control \& Git Tools](#version-control--git-tools)
  - [Repository Management](#repository-management)
    - [`git-stage-fixups`](#git-stage-fixups)
    - [`git-apply-fixups`](#git-apply-fixups)
  - [AI-Assisted Git Tools](#ai-assisted-git-tools)
    - [`git-ai-commit`](#git-ai-commit)
    - [`git-squash-commit-messages`](#git-squash-commit-messages)

This repository contains various utility scripts, primarily in Bash and Python, to assist with git.

## Version Control & Git Tools

### Repository Management

#### `git-stage-fixups`
Creates separate commits for each modified file, with commit messages that reference their previous commits. Part of a workflow with `git-apply-fixups` for efficiently managing related changes across multiple files.

Usage:
```bash
git-stage-fixups [-n|--dry-run]
```

Options:
- `-n, --dry-run`: Show what would be done without making changes

#### `git-apply-fixups`
Automatically reorders and optionally squashes fixup commits created by `git-stage-fixups`. This provides an automated alternative to manually reordering commits in an interactive rebase.

**Workflow**:
1. Make changes to multiple files
2. Run `git-stage-fixups` to create separate commits for each file
3. Run `git-apply-fixups` to automatically reorder (and optionally squash) the commits

**Usage**:
```bash
# Show proposed reordering without executing
git-apply-fixups --dry-run

# Reorder and mark fixups for squashing
git-apply-fixups --squash

# Only process recent commits
git-apply-fixups --since="2 days ago"
git-apply-fixups -n 10
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

#### `git-squash-commit-messages`
Uses an AI language model to combine multiple git commit messages into a single, comprehensive message. Useful when squashing commits or preparing pull request descriptions.

```bash
# Combine the last 3 commit messages
git-squash-commit-messages HEAD~3..HEAD

# Combine messages between specific commits
git-squash-commit-messages abc123..def456

# Use a specific model
git-squash-commit-messages -m gpt-4 HEAD~3..HEAD
```
