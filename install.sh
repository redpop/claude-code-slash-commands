#!/bin/bash

# Claude Code Slash Commands Installation Script
# Usage: curl -fsSL <url> | bash -s -- <prefix>
# Example: curl -fsSL <url> | bash -s -- mytools

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
REPO_URL="https://github.com/redpop/claude-code-slash-commands.git"
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"

# Function to print colored output
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Check if prefix is provided
if [ -z "$1" ]; then
    print_error "No prefix provided. Usage: $0 <prefix>"
    echo "Example: $0 mytools"
    exit 1
fi

PREFIX="$1"
INSTALL_PATH="$CLAUDE_COMMANDS_DIR/$PREFIX"

# Check if git is installed
if ! command -v git &> /dev/null; then
    print_error "Git is not installed. Please install git first."
    exit 1
fi

# Create Claude commands directory if it doesn't exist
if [ ! -d "$CLAUDE_COMMANDS_DIR" ]; then
    print_info "Creating Claude commands directory: $CLAUDE_COMMANDS_DIR"
    mkdir -p "$CLAUDE_COMMANDS_DIR"
fi

# Check if prefix directory already exists
if [ -d "$INSTALL_PATH" ]; then
    echo -e "${YELLOW}Warning: Directory $INSTALL_PATH already exists.${NC}"
    read -p "Do you want to update it? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Updating existing installation..."
        cd "$INSTALL_PATH"
        git pull
        print_success "Updated successfully!"
    else
        print_info "Installation cancelled."
        exit 0
    fi
else
    # Clone the repository
    print_info "Cloning repository to $INSTALL_PATH..."
    git clone "$REPO_URL" "$INSTALL_PATH"
    print_success "Repository cloned successfully!"
fi

# Display available commands
echo
print_success "Installation complete!"
echo
echo "Available commands:"
echo

# Find all .md files in the commands directory
if [ -d "$INSTALL_PATH/commands" ]; then
    while IFS= read -r -d '' file; do
        # Get relative path from commands directory
        relative_path="${file#$INSTALL_PATH/commands/}"
        # Remove .md extension
        command_path="${relative_path%.md}"
        # Replace / with :
        command_name="${command_path//\//:}"
        echo "  /${PREFIX}:${command_name}"
    done < <(find "$INSTALL_PATH/commands" -name "*.md" -type f -print0 | sort -z)
fi

echo
echo "To use these commands in Claude Code, type '/' followed by the command name."
echo
echo "To update in the future, run:"
echo "  cd $INSTALL_PATH && git pull"
echo
print_success "Happy coding with Claude Code! 🚀"