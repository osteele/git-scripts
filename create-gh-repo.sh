#!/bin/bash

# Script to create a GitHub repository and set its description and topics
# Usage: ./create-gh-repo.sh <repo-name> <description> <topic1,topic2,topic3>

set -e

# Check if required arguments are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <repo-name> <description> [topics]"
    echo "Example: $0 my-project 'A cool project' 'javascript,web,opensource'"
    exit 1
fi

REPO_NAME="$1"
DESCRIPTION="$2"
TOPICS="${3:-}"

echo "Creating GitHub repository: $REPO_NAME"

# Check if gh CLI is authenticated
if ! gh auth status > /dev/null 2>&1; then
    echo "Error: Not authenticated with GitHub CLI. Please run 'gh auth login' first."
    exit 1
fi

# Create the repository
echo "Creating repository..."
gh repo create "$REPO_NAME" \
    --description "$DESCRIPTION" \
    --public \
    --clone=false

echo "Repository created successfully!"

# Set topics if provided
if [ -n "$TOPICS" ]; then
    echo "Setting repository topics..."
    # Convert comma-separated topics to space-separated for gh command
    TOPICS_FORMATTED=$(echo "$TOPICS" | tr ',' ' ')
    gh repo edit "$REPO_NAME" --add-topic $TOPICS_FORMATTED
    echo "Topics set successfully!"
fi

# Display repository information
echo "Repository details:"
gh repo view "$REPO_NAME" --json name,description,repositoryTopics,url,visibility \
    --template '{{.name}}: {{.description}}
URL: {{.url}}
Visibility: {{.visibility}}
Topics: {{range .repositoryTopics}}{{.name}} {{end}}
'

echo "Done! Repository '$REPO_NAME' has been created and configured."
