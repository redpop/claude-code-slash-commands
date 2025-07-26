---
description: Update git hooks to the latest version in Claude command installations
argument-hint: [--all] [--check-only]
---

# Claude Command: Update Hooks

This command updates the git hooks in your Claude command installations to the latest version. This is useful when the repository's hook implementation has been improved or fixed.

## Usage

```
/update-hooks             # Update hooks in current installation
/update-hooks --all       # Update hooks in all installations
/update-hooks --check-only # Check if updates are available without applying
```

### Arguments

- `--all`: Update hooks in all installations found in ~/.claude/commands
- `--check-only`: Only check if updates are available without making changes

## What This Command Does

1. **Detects Installation Type**:
   - Checks if you're in a Claude commands installation directory
   - Or scans ~/.claude/commands for all installations
   - Validates that git hooks exist

2. **Version Checking**:
   - Reads current hook version from your installation
   - Fetches latest hook version from the repository
   - Compares versions to determine if update is needed

3. **Safe Update Process**:
   - Creates backups of existing hooks before updating
   - Downloads latest hook implementation
   - Preserves your sparse-checkout configuration
   - Runs the hook once to ensure everything syncs

4. **Multi-Installation Support**:
   - Can update a single installation
   - Or update all installations at once with --all
   - Shows progress for each installation

## Hook Versioning

Git hooks include a version number in their header:
```bash
# Hook version: 2
```

This allows the system to:
- Track which version you're running
- Notify you when updates are available
- Ensure compatibility with repository changes

## When to Update Hooks

You should update hooks when:
- You see a notification after `git pull` about available updates
- You experience issues with command synchronization
- The repository announces hook improvements
- You want to ensure you have the latest fixes

## Update Process

### Single Installation
```bash
cd ~/.claude/commands/myprefix
/update-hooks
```

Output:
```
→ Fetching latest hook version...
→ Current hook version: 1
→ Latest hook version: 2
→ Backed up current post-merge hook
→ Backed up current post-checkout hook
→ Installing new hooks...
✓ Hooks updated successfully to version 2!
→ Running hook to sync commands...
✓ Hook update complete!
```

### All Installations
```bash
/update-hooks --all
```

Output:
```
→ Found Claude commands directory, checking for installations...

→ Found installation: global
Update hooks for 'global'? (y/N) y
→ Fetching latest hook version...
✓ Hooks updated successfully to version 2!

→ Found installation: personal
Update hooks for 'personal'? (y/N) y
✓ Hooks are already up to date (version 2)
```

### Check Only Mode
```bash
/update-hooks --check-only
```

Output:
```
→ Checking hook versions...
Current version: 1
Latest version: 2
⚠️ Update available! Run without --check-only to update.
```

## What Gets Updated

The update process modifies:
- `.git/hooks/post-merge` - Main hook for syncing commands
- `.git/hooks/post-checkout` - Alternate hook for git operations

The update preserves:
- Your sparse-checkout configuration
- Your local command files
- Your git repository state
- Any custom modifications to other git settings

## Automatic Update Notifications

After each `git pull`, if your hooks are outdated, you'll see:
```
⚠️  Hook Update Available!
Your git hooks are version 1, but version 2 is available.
Run the following command to update your hooks:

  curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/scripts/update-hooks.sh | bash

Or manually reinstall with the latest install.sh
```

## Manual Update Methods

### Method 1: Using this command
```bash
/update-hooks
```

### Method 2: Using the update script directly
```bash
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/scripts/update-hooks.sh | bash
```

### Method 3: Reinstalling
```bash
cd ~/.claude/commands
rm -rf myprefix
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- myprefix
```

## Rollback

If you need to rollback after an update:
```bash
cd ~/.claude/commands/myprefix
cp .git/hooks/post-merge.backup .git/hooks/post-merge
cp .git/hooks/post-checkout.backup .git/hooks/post-checkout
```

## Technical Details

The update process:
1. Downloads the latest install.sh from the repository
2. Extracts the hook content between HOOKEOF markers
3. Reads the version number from the hook header
4. Compares with your current version
5. If newer, replaces your hooks with the latest version
6. Runs the hook once to ensure proper synchronization

## Best Practices

- Always check for updates after pulling repository changes
- Update hooks when you experience sync issues
- Keep all your installations on the same hook version
- Review update notifications after git pull
- Test commands after updating to ensure everything works

## Error Handling

The command handles:
- **Network issues**: Fails gracefully if can't download latest version
- **Permission problems**: Reports if can't write to hook files
- **Invalid installations**: Skips directories that aren't git repositories
- **Version parsing**: Handles missing or malformed version numbers
- **Backup failures**: Warns if can't create backups

## Important Notes

- Hook updates are separate from command updates
- Updating hooks doesn't change your command files
- Backups are created automatically before updates
- The update is safe and can be rolled back if needed
- Hook versions are independent of repository versions