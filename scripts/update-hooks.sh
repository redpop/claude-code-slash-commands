#!/bin/bash

# Update git hooks for Claude Code Slash Commands installations
# This script updates the git hooks in existing installations to the latest version

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

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

# Check if we're in a claude commands installation
if [ ! -d ".git" ] || [ ! -f ".git/hooks/post-merge" ]; then
    # Try common locations
    if [ -d "$HOME/.claude/commands" ]; then
        print_info "Found Claude commands directory, checking for installations..."
        
        for dir in "$HOME/.claude/commands"/*; do
            if [ -d "$dir/.git" ]; then
                basename_dir=$(basename "$dir")
                echo ""
                print_info "Found installation: $basename_dir"
                read -p "Update hooks for '$basename_dir'? (y/N) " -n 1 -r
                echo
                
                if [[ $REPLY =~ ^[Yy]$ ]]; then
                    cd "$dir"
                    "$0"  # Re-run this script in the installation directory
                    cd - > /dev/null
                fi
            fi
        done
        exit 0
    else
        print_error "This script must be run from a Claude commands installation directory"
        print_error "Or run from anywhere to update all installations in ~/.claude/commands"
        exit 1
    fi
fi

# Get the latest install.sh from the repository
print_info "Fetching latest hook version..."
TEMP_FILE=$(mktemp)
trap 'rm -f $TEMP_FILE' EXIT

# Get repository URL from git config or remote
REPO_URL=$(git config claude.repo-url || git config --get remote.origin.url)
if [ -z "$REPO_URL" ]; then
    print_error "Could not determine repository URL"
    exit 1
fi

# Extract owner and repo name for URL construction
if [[ "$REPO_URL" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
    RAW_URL="https://raw.githubusercontent.com/$OWNER/$REPO_NAME/main"
elif [[ "$REPO_URL" =~ gitlab\.com[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
    RAW_URL="https://gitlab.com/$OWNER/$REPO_NAME/-/raw/main"
elif [[ "$REPO_URL" =~ bitbucket\.org[:/]([^/]+)/([^/.]+) ]]; then
    OWNER="${BASH_REMATCH[1]}"
    REPO_NAME="${BASH_REMATCH[2]}"
    RAW_URL="https://bitbucket.org/$OWNER/$REPO_NAME/raw/main"
else
    # Fallback - construct a generic raw URL
    RAW_URL=$(echo "$REPO_URL" | sed -e 's/\.git$//' -e 's/$/\/raw\/main/')
    print_info "Warning: Using generic raw URL construction, may not work for all git hosts"
fi

if curl -fsSL "${RAW_URL}/install.sh" -o "$TEMP_FILE"; then
    # Extract the hook content from install.sh
    # Find the line starting with "cat > .git/hooks/post-merge"
    START_LINE=$(grep -n "cat > .git/hooks/post-merge << 'HOOKEOF'" "$TEMP_FILE" | head -1 | cut -d: -f1)
    END_LINE=$(grep -n "^HOOKEOF$" "$TEMP_FILE" | head -1 | cut -d: -f1)
    
    if [ -n "$START_LINE" ] && [ -n "$END_LINE" ]; then
        # Extract hook version - look for version in the hook header
        HOOK_VERSION=$(sed -n "$((START_LINE+1)),$((START_LINE+10))p" "$TEMP_FILE" | grep "^# Hook version:" | sed 's/.*: //')
        CURRENT_VERSION=$(head -10 .git/hooks/post-merge 2>/dev/null | grep "^# Hook version:" | sed 's/.*: //')
        
        if [ -z "$HOOK_VERSION" ]; then
            print_error "Could not find hook version in latest install.sh"
            exit 1
        fi
        
        if [ "$HOOK_VERSION" = "$CURRENT_VERSION" ]; then
            print_success "Hooks are already up to date (version $CURRENT_VERSION)"
            exit 0
        fi
        
        print_info "Current hook version: ${CURRENT_VERSION:-unknown}"
        print_info "Latest hook version: $HOOK_VERSION"
        
        # Backup current hooks
        if [ -f ".git/hooks/post-merge" ]; then
            cp .git/hooks/post-merge .git/hooks/post-merge.backup
            print_info "Backed up current post-merge hook"
        fi
        
        if [ -f ".git/hooks/post-checkout" ]; then
            cp .git/hooks/post-checkout .git/hooks/post-checkout.backup
            print_info "Backed up current post-checkout hook"
        fi
        
        # Extract and install new hooks
        print_info "Installing new hooks..."
        sed -n "$((START_LINE+1)),$((END_LINE-1))p" "$TEMP_FILE" > .git/hooks/post-merge
        chmod +x .git/hooks/post-merge
        
        # Copy to post-checkout
        cp .git/hooks/post-merge .git/hooks/post-checkout
        chmod +x .git/hooks/post-checkout
        
        print_success "Hooks updated successfully to version $HOOK_VERSION!"
        
        # Run the new hook once to ensure everything is in sync
        print_info "Running hook to sync commands..."
        ./.git/hooks/post-merge
        
    else
        print_error "Could not extract hook content from install.sh"
        exit 1
    fi
else
    print_error "Failed to download latest install.sh"
    exit 1
fi

print_success "Hook update complete!"