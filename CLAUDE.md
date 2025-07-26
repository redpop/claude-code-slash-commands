# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a centralized repository for reusable Claude Code slash commands. The repository is designed to be cloned into `~/.claude/commands/` with a custom prefix (e.g., `~/.claude/commands/myprefix/`), making all commands available with that prefix.

## Repository Structure

```
claude-code-slash-commands/
├── commands/                # All slash command definitions
│   └── git/                # Git-related commands
│       └── commit.md       # Structured git commit command
├── scripts/                 # Utility scripts
│   └── update-readme.sh    # Auto-generates command documentation
├── install.sh              # Installation script
├── README.md              # User documentation (partially auto-generated)
├── CLAUDE.md              # This file
└── LICENSE                # MIT License
```

## Key Concepts

### Command Naming Convention

- Commands are organized in subdirectories under `commands/`
- Directory structure determines command namespace: `commands/category/command.md` → `/prefix:category:command`
- Use lowercase with hyphens for multi-word names

### Command Format

Each command is a Markdown file containing:

1. **Frontmatter** (YAML format) with Claude Code-compatible fields:
   - `description`: Brief command description
   - `argument-hint`: Expected arguments for auto-completion
2. Command description and usage instructions
3. Detailed workflow steps
4. Best practices and guidelines
5. Examples of expected output

## Development Guidelines

### Adding New Commands

1. Create appropriate category directory under `commands/` if needed
2. Create `.md` file with descriptive command name
3. Add frontmatter with at minimum a `description` field
4. Write command as detailed Markdown prompt with clear instructions
5. Include usage examples and expected behaviors
6. Run `./scripts/update-readme.sh` to update README documentation

### Testing Commands

- After adding a command, test it by installing locally: `~/.claude/commands/test/`
- Verify command appears with correct namespace
- Test command execution in a sample project

### Installation Script Updates

The `install.sh` script handles:

- Cloning repository using Git sparse checkout to specified prefix location
- Creating a Git repository structure that only contains command files
- Automatically updating existing installations via `git pull`
- Handling migration from old non-Git installations
- Listing available commands after installation

Key features:
- Uses Git sparse checkout to only track command files
- Moves command files from `commands/` subdirectory to the root of the installation
- Creates post-merge hooks to maintain structure during updates
- Preserves local changes during updates using git stash

Update the `REPO_URL` variable in `install.sh` when forking or moving the repository.

## Current Commands

### `/prefix:git:commit`

Advanced git commit command that:

- Runs pre-commit checks (lint, build, docs) unless `--no-verify` is specified
- Analyzes changes and suggests splitting into multiple commits when appropriate
- Uses conventional commit format with emojis
- Handles both staged and unstaged files intelligently

### `/prefix:project:changelog`

Changelog management command that:

- Adds entries to CHANGELOG.md following Keep a Changelog format
- Supports semantic versioning validation
- Can automatically update version in package files
- Includes emoji prefixes for change types
- Optionally commits changes with conventional commit message

### `/prefix:ai:handoff`

AI context handoff command that:

- Analyzes current problem state and generates comprehensive documentation
- Creates markdown file suitable for sharing with other AI assistants
- Includes code snippets, directory structure, and recent changes
- Captures context of ongoing tasks and next steps
- Useful for switching between AI assistants or documenting work state

## Important Notes

- All documentation should be written in English
- Commands should be self-contained and include all necessary context
- Avoid creating example or demo commands - focus on practical, reusable tools
- The $ARGUMENTS placeholder in commands receives user input after the command invocation

## Code Quality & Linting

### Shellcheck for Bash Scripts

All bash scripts in this repository should be validated with shellcheck to ensure they follow best practices and avoid common pitfalls. This includes:

- `install.sh` - Installation script
- `scripts/update-readme.sh` - README update script
- Any future bash scripts added to the repository

#### Running Shellcheck

```bash
# Check individual script
shellcheck install.sh

# Check all scripts
shellcheck scripts/*.sh install.sh
```

#### Common Shellcheck Recommendations

- Always quote variables: `"$variable"` instead of `$variable`
- Use `[[ ]]` instead of `[ ]` for conditional expressions
- Prefer `$()` over backticks for command substitution
- Handle potential failures with proper error checking
- Use proper array handling syntax

#### CI Integration

Consider adding shellcheck to your CI pipeline to automatically validate scripts on every commit.

## README Maintenance

The README.md file contains an auto-generated section for command documentation:

### Auto-generated Section
- The section between `<!-- COMMANDS:START - DO NOT EDIT -->` and `<!-- COMMANDS:END -->` is automatically maintained
- **DO NOT manually edit** content between these markers - changes will be overwritten
- Run `./scripts/update-readme.sh` after adding/modifying commands

### Update Process
1. The script scans all `.md` files in the `commands/` directory
2. Extracts frontmatter metadata (`description` and `argument-hint`)
3. Generates a formatted table with all commands
4. Updates only the marked section in README.md

### Manual Sections
All other sections of the README can be edited normally:
- Installation instructions
- Usage examples
- Contributing guidelines
- License information
