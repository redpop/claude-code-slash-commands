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

- Cloning repository to specified prefix location
- Updating existing installations
- Listing available commands after installation

Update the `REPO_URL` variable in `install.sh` when forking or moving the repository.

## Current Commands

### `/prefix:git:commit`

Advanced git commit command that:

- Runs pre-commit checks (lint, build, docs) unless `--no-verify` is specified
- Analyzes changes and suggests splitting into multiple commits when appropriate
- Uses conventional commit format with emojis
- Handles both staged and unstaged files intelligently

## Important Notes

- All documentation should be written in English
- Commands should be self-contained and include all necessary context
- Avoid creating example or demo commands - focus on practical, reusable tools
- The $ARGUMENTS placeholder in commands receives user input after the command invocation

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
