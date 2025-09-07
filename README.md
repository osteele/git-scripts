# Git Scripts

A collection of utility scripts for Git repositories, including AI-powered commit message generation and repository management tools.

Note: Some scripts in this repository were contributed by other authors and are clearly attributed in the individual script descriptions below and in the script source code.

For Jujutsu (jj) version control scripts, see: https://github.com/osteele/jj-scripts

For more development tools, see: https://osteele.com/software/development-tools

## Installation

These script names begin with `git-`, so that they can be used as git subcommands, e.g. `git ai-commit` as an alternative to `git-ai-commit`.

Clone this repository and add it to your PATH, or copy the scripts to a directory already in your PATH.

## Repository Management Tools

### `git-wtf`
Displays a readable summary of a repository's state, including branch relationships to remote repositories and other branches. Useful for working with multiple branches in complex repositories.

Copyright 2008--2009 William Morgan.

```bash
git-wtf
```

### `git-show-merges`
Lists branches that have been merged into the current branch and those that have not. Useful for tracking the status of branches and their relationships within a repository.

```bash
git-show-merges [BRANCHES...] # Shows merge status of specified or all branches
```

### `git-show-large-objects`
Displays the largest objects in a Git repository's pack files, helpful for identifying and potentially cleaning up large files in a repository.

```bash
git-show-large-objects
```

Written by Antony Stubbs, as `show-large-git-objects`.

### `git-rank-contributors`
Ranks contributors based on the size of diffs they've made in the repository. This script can be valuable for creating contributor credit lists, although manual adjustments may be needed if contributors commit from multiple email addresses.

```bash
git-rank-contributors [-v] [-o] [-h] # -v for verbose, -o to obfuscate emails
```

### `git-create-fixups`
Creates separate commits for each modified file, with commit messages that reference their previous commits. Part of a workflow with `git-apply-fixups` for efficiently managing related changes across multiple files.

Usage:
```bash
git-create-fixups [-n|--dry-run]
```

### `git-apply-fixups`
Automatically reorders and optionally squashes fixup commits created by `git-create-fixups`. This provides an automated alternative to manually reordering commits in an interactive rebase.

**Workflow**:
1. Make changes to multiple files
2. Run `git-create-fixups` to create separate commits for each file
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

## AI-Assisted Git Tools

These AI-powered tools use the `llm` command-line tool to generate and modify commit messages. You can configure a custom model for all commit message generation by setting an alias:

```bash
# Set a preferred model for commit messages
llm aliases set ai-commit-message "openrouter/google/gemini-2.5-flash-lite"
# Or use any other available model
llm aliases set ai-commit-message "claude-3.5-sonnet"
llm aliases set ai-commit-message "gpt-4"

# Check your current aliases
llm aliases

# Remove the alias to use the default model selection
llm aliases remove ai-commit-message
```

### `git-ai-commit`
Automatically generates and commits changes using AI-generated commit messages. Commits both staged and unstaged changes to tracked files (like `git commit -a`), and by default also stages and commits untracked files.

```bash
# Generate and commit all changes
git-ai-commit

# Preview changes without committing (dry run)
git-ai-commit -d

# Skip pre-commit hooks and untracked files
git-ai-commit -n

# Use a specific LLM model
git-ai-commit -m gpt-4

# List available models
git-ai-commit -l
```

### `git-ai-reword-message`
Generates a new commit message for a specified commit based on analyzing its changes. Uses LLM to create a descriptive and accurate commit message that reflects the actual changes in the commit.

```bash
# Rewrite message for the most recent commit
git-ai-reword-message

# Rewrite message for a specific commit
git-ai-reword-message <commit-hash>

# Preview the new message without applying it
git-ai-reword-message -n

# Use a specific LLM model
git-ai-reword-message --model gpt-4

# Modify the message according to specific instructions
git-ai-reword-message --prompt "Make the message more concise"
```

### `git-ai-squash-messages`
Generates commit messages based on changes using AI assistance. Designed to streamline commit message creation and ensure consistent descriptions.

```bash
git-ai-squash-messages # Analyzes messages and proposes a combined commit message
```

### `git-ai-squash-commit-messages`
Uses an AI language model to combine multiple git commit messages into a single, comprehensive message. Useful when squashing commits or preparing pull request descriptions.

```bash
# Combine the last 3 commit messages
git-ai-squash-commit-messages HEAD~3..HEAD

# Combine messages between specific commits
git-ai-squash-commit-messages abc123..def456

# Use a specific model
git-ai-squash-commit-messages -m gpt-4 HEAD~3..HEAD
```

### `git-ai-release-notes`
Generates a blog post announcing a new version based on git commits. Uses a LLM to create a well-structured announcement that categorizes and highlights the most important changes.

```bash
# Generate a post from all commits
git-ai-release-notes

# Generate a post from the last 5 commits
git-ai-release-notes HEAD~5..HEAD

# Generate a post from commits between two tags
git-ai-release-notes v1.0..v1.1

# Generate a post from commits in the last day
git-ai-release-notes --since="1 day ago"

# Save the output to a file
git-ai-release-notes -o announcement.md

# Output raw markdown without rich formatting
git-ai-release-notes --raw

# Use a different tone/style
git-ai-release-notes --tone=technical    # More technical details
git-ai-release-notes --tone=casual       # Conversational style
git-ai-release-notes --tone=enthusiastic # Excited and energetic
git-ai-release-notes --tone=minimal      # Just the facts
git-ai-release-notes --tone=pirate       # Arr, matey! Pirate speak
git-ai-release-notes --tone=nerd         # For the technically obsessed
git-ai-release-notes --tone=apologetic   # Sorry for the update...
```

The script automatically determines the project name from any project files, or failing that the remote repository name or the local directory name, but you can also specify it with the `--project-name` option.

### `gh-repo-set-metadata`
Sets GitHub repository metadata from local files. Updates repository description and topics from package.json or other project configuration files.

```bash
gh-repo-set-metadata
```

## License

MIT License
