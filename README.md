# Claude Code Slash Commands

A centralized repository for reusable Claude Code slash commands that can be installed as a Git repository in `~/.claude/commands` with a custom prefix.

## Installation

### Method 1: Manual Clone

```bash
# Clone the repository with your desired prefix
git clone https://github.com/redpop/claude-code-slash-commands.git ~/.claude/commands/myprefix

# Or fork and use your own repository
git clone https://github.com/YourUsername/claude-code-slash-commands.git ~/.claude/commands/myprefix
```

### Method 2: Installation Script (Recommended)

```bash
# Download and run the installation script
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- myprefix

# Or from your own fork
curl -fsSL https://raw.githubusercontent.com/YourUsername/claude-code-slash-commands/main/install.sh | bash -s -- myprefix
```

## Usage

After installation, all commands are available with your chosen prefix:

```
/myprefix:git:commit
/myprefix:ai:handoff
/myprefix:project:changelog
```

## Updates

To update the commands to the latest version:

```bash
cd ~/.claude/commands/myprefix
git pull
```

## Available Commands

<!-- COMMANDS:START - DO NOT EDIT -->

### Ai Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:ai:handoff` | Documents current problem context for handoff to another AI assistant | `output-file` |


### Git Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:git:commit` | Creates structured Git commits with Conventional Commit format and emojis | `--no-verify`, `--fast` |


### Project Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:project:changelog` | AI-powered CHANGELOG.md management that automatically determines version based on changes | `--analyze`, `--commit`, `--update-version` |

<!-- COMMANDS:END -->

## Adding Custom Commands

1. Create a new folder under `commands/` for your category
2. Create a `.md` file with your command name
3. Write your command logic as a Markdown prompt

### Example structure for a new command:

```
commands/
└── my-category/
    └── my-command.md
```

This command would be available as: `/myprefix:my-category:my-command`

## Command Naming Conventions

- Use descriptive names in lowercase
- Separate words with hyphens (`-`)
- Group related commands in common folders

## Maintaining Commands

When adding or modifying commands:

1. Ensure each command has proper frontmatter with `description` and optional `argument-hint`
2. Run `./scripts/update-readme.sh` to update the command list below
3. The "Available Commands" section is auto-generated - do not edit manually

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your commands with proper frontmatter
4. Run `./scripts/update-readme.sh` to update documentation
5. Create a pull request

## License

See [LICENSE](LICENSE) file for details.
