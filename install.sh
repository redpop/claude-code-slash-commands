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

# Check if prefix directory already exists and is a git repository
if [ -d "$INSTALL_PATH/.git" ]; then
    print_info "Updating existing installation..."
    cd "$INSTALL_PATH"
    
    # Stash any local changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        print_info "Stashing local changes..."
        git stash push -m "Auto-stash before update"
    fi
    
    # Pull latest changes
    if git pull --ff-only origin main; then
        print_success "Updated successfully!"
        
        # Check if there were stashed changes
        if git stash list | grep -q "Auto-stash before update"; then
            print_info "Reapplying local changes..."
            git stash pop || print_error "Failed to reapply local changes. Check 'git stash list'"
        fi
    else
        print_error "Failed to update. You may have local changes that conflict."
        echo "Try resolving conflicts manually in: $INSTALL_PATH"
        exit 1
    fi
elif [ -d "$INSTALL_PATH" ]; then
    # Directory exists but is not a git repository
    echo -e "${YELLOW}Warning: Directory $INSTALL_PATH exists but is not a git repository.${NC}"
    echo "This appears to be an old installation. Would you like to replace it with a git-based installation?"
    echo "This will enable easy updates with 'git pull' in the future."
    read -p "Replace with git-based installation? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Backing up existing installation..."
        mv "$INSTALL_PATH" "${INSTALL_PATH}.backup"
        print_info "Old installation backed up to: ${INSTALL_PATH}.backup"
    else
        print_info "Installation cancelled."
        exit 0
    fi
fi

# Fresh installation
if [ ! -d "$INSTALL_PATH/.git" ]; then
    print_info "Installing commands to $INSTALL_PATH..."
    
    # Clone the full repository first
    if ! git clone "$REPO_URL" "$INSTALL_PATH"; then
        print_error "Failed to clone repository"
        exit 1
    fi
    
    cd "$INSTALL_PATH"
    
    # Enable sparse checkout
    git config core.sparseCheckout true
    
    # Configure sparse checkout to only track commands directory
    echo "commands/*" > .git/info/sparse-checkout
    
    # Re-read the tree with sparse checkout
    git read-tree -m -u HEAD
    
    # Move commands content to root and remove everything else
    if [ -d "commands" ]; then
        # Move all content from commands/ to root
        mv commands/* . 2>/dev/null || true
        mv commands/.[^.]* . 2>/dev/null || true
        
        # Remove the now-empty commands directory
        rmdir commands 2>/dev/null || true
        
        # Remove all other files/directories that shouldn't be here
        rm -rf README.md LICENSE install.sh scripts CLAUDE.md .gitignore CHANGELOG.md 2>/dev/null || true
        
        # Update sparse checkout to track the new structure
        echo "/*" > .git/info/sparse-checkout
        echo "!README.md" >> .git/info/sparse-checkout
        echo "!LICENSE" >> .git/info/sparse-checkout
        echo "!install.sh" >> .git/info/sparse-checkout
        echo "!scripts" >> .git/info/sparse-checkout
        echo "!CLAUDE.md" >> .git/info/sparse-checkout
        echo "!.gitignore" >> .git/info/sparse-checkout
        echo "!CHANGELOG.md" >> .git/info/sparse-checkout
        echo "!commands" >> .git/info/sparse-checkout
        
        # Create a custom git hook to handle updates
        cat > .git/hooks/post-merge << 'EOF'
#!/bin/bash
# Post-merge hook to handle directory structure after pull

# Check if commands directory exists after merge
if [ -d "commands" ]; then
    # Move content from commands/ to root
    for item in commands/*; do
        if [ -e "$item" ]; then
            base_name=$(basename "$item")
            # If directory already exists, merge content
            if [ -d "$base_name" ]; then
                cp -r "$item"/* "$base_name/" 2>/dev/null || true
            else
                mv "$item" . 2>/dev/null || true
            fi
        fi
    done
    # Remove empty commands directory
    rmdir commands 2>/dev/null || true
fi

# Clean up any unwanted files
rm -rf README.md LICENSE install.sh scripts CLAUDE.md .gitignore CHANGELOG.md 2>/dev/null || true
EOF
        chmod +x .git/hooks/post-merge
        
        print_success "Commands installed successfully!"
    else
        print_error "No commands directory found in repository"
        cd ..
        rm -rf "$INSTALL_PATH"
        exit 1
    fi
fi

# Display available commands
echo
print_success "Installation complete!"
echo
echo "Available commands:"
echo

# Find all .md files in the installation directory
if [ -d "$INSTALL_PATH" ]; then
    while IFS= read -r -d '' file; do
        # Skip hidden directories like .git
        if [[ "$file" == *"/.git/"* ]]; then
            continue
        fi
        # Get relative path from installation directory
        relative_path="${file#"$INSTALL_PATH/"}"
        # Remove .md extension
        command_path="${relative_path%.md}"
        # Replace / with :
        command_name="${command_path//\//:}"
        echo "  /${PREFIX}:${command_name}"
    done < <(find "$INSTALL_PATH" -name "*.md" -type f -print0 | sort -z)
fi

echo
echo "To use these commands in Claude Code, type '/' followed by the command name."
echo
echo "To update in the future:"
echo "  cd $INSTALL_PATH && git pull"
echo "  # or run this install script again:"
echo "  curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- $PREFIX"
echo
print_success "Happy coding with Claude Code! 🚀"