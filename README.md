# Claude Code Slash Commands

> ⚠️ **IMPORTANT: This repository is no longer maintained!**
> 
> 🚀 **We've moved to [claude-code-toolkit](https://github.com/redpop/claude-code-toolkit)**
> 
> The new repository includes:
> - ✨ All existing slash commands
> - 🤖 AI Agents for code analysis
> - 🛠️ Enhanced tools and utilities
> - 🔄 Improved installation process
> 
> Please update your installations:
> ```bash
> curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- myprefix
> ```

---

**[Archived]** A centralized repository for reusable Claude Code slash commands that can be installed as a Git repository in `~/.claude/commands` with a custom prefix.

## Installation (Deprecated)

> **Note:** Please use the new [claude-code-toolkit](https://github.com/redpop/claude-code-toolkit) instead!

For existing installations:

```bash
# Install with your chosen prefix (e.g., "myprefix", "global", etc.)
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- myprefix

# Or from your own fork (automatic detection)
export CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git"
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix

# Or as a one-liner
CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git" curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
```

The installation script will:
- Clone the repository using Git sparse checkout
- Set up only the command files in `~/.claude/commands/myprefix/`
- Create a Git repository structure that allows easy updates
- Display all available commands after installation
- Automatically detect fork URLs and configure accordingly

## Forking This Repository

Forking this repository allows you to:
- Create and maintain your own custom commands
- Share team-specific tools and workflows
- Contribute back improvements to the original repository
- Customize command behaviors for your specific needs

### Step-by-Step Forking Instructions

1. **Fork on GitHub**
   - Visit the [original repository](https://github.com/redpop/claude-code-slash-commands)
   - Click the "Fork" button in the top right
   - Choose your account/organization as the destination

2. **Clone and Install Your Fork**
   ```bash
   # The install script automatically detects fork URLs
   curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
   
   # Or explicitly set the repository URL
   CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git" \
     curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
   ```

3. **Verify Fork Configuration**
   ```bash
   # Check the remote URL
   cd ~/.claude/commands/myprefix
   git remote -v
   
   # Should show your fork URL:
   # origin  https://github.com/YourUsername/your-fork.git (fetch)
   # origin  https://github.com/YourUsername/your-fork.git (push)
   ```

### Benefits of Forking

- **Custom Commands**: Add proprietary or project-specific commands without affecting the original repository
- **Team Collaboration**: Share standardized workflows across your organization
- **Experimentation**: Test new command ideas before contributing upstream
- **Version Control**: Maintain your own release cycle and versioning

## Fork Configuration

Your fork can be customized using the `.claude-commands.json` configuration file in the repository root.

### Configuration File Structure

Create a `.claude-commands.json` file in your fork's root directory:

```json
{
  "name": "My Team's Claude Commands",
  "description": "Custom commands for our development workflow",
  "defaultPrefix": "team",
  "upstream": "https://github.com/redpop/claude-code-slash-commands.git",
  "customCommands": {
    "categories": ["deploy", "testing", "internal"]
  }
}
```

### Configuration Options

- **name**: Display name for your command collection
- **description**: Brief description of your fork's purpose
- **defaultPrefix**: Suggested prefix for installations (users can override)
- **upstream**: Original repository URL for syncing updates
- **customCommands**: Metadata about your custom command categories

### Custom Prefix Support

When installing from a fork, you can still use any prefix:

```bash
# Install with default prefix from config
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash

# Override with custom prefix
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash -s -- custom

# Multiple installations with different prefixes
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- global
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash -s -- team
```

This allows you to have both the original commands and your fork's commands available simultaneously:

## Usage

After installation, all commands are available with your chosen prefix:

```
# Original repository commands
/global:git:commit
/global:ai:handoff
/global:project:changelog

# Fork-specific commands
/team:deploy:staging
/team:testing:integration
/team:internal:setup
```

## Updates

Since the installation creates a Git repository, you can easily update your commands:

### Method 1: Using Git (Recommended)
```bash
cd ~/.claude/commands/myprefix
git pull
```

### Method 2: Re-run Installation Script
```bash
# For original repository
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/install.sh | bash -s -- myprefix

# For your fork
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
```

Both methods will preserve any local changes you've made to the commands.

### Hook Updates

Git hooks are versioned separately from commands. After a `git pull`, you may see a notification about available hook updates:

```
⚠️  Hook Update Available!
Your git hooks are version 2, but version 3 is available.
```

To update hooks:
```bash
# Method 1: Use the update-hooks slash command
/myprefix:project:update-hooks

# Method 2: Run the update script directly
cd ~/.claude/commands/myprefix
./.git/hooks/post-merge  # This will show the update command

# Method 3: Update all installations at once (original repo)
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-slash-commands/main/scripts/update-hooks.sh | bash

# Or from your fork
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/scripts/update-hooks.sh | bash
```

## Available Commands

<!-- COMMANDS:START - DO NOT EDIT -->

### Ai Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:ai:handoff` | Documents current problem context for handoff to another AI assistant | `output-file` |


### Analysis Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:analysis:five-whys` | Apply the Five Whys root cause analysis technique to investigate issues | `issue_description` |


### Code Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:code:shellcheck` | Automatically fix shell script issues using shellcheck analysis | `--check-only`, `--strict`, `--summary-only` |


### Git Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:git:commit` | Creates structured Git commits with Conventional Commit format and emojis | `--no-verify`, `--fast`, `--push` |


### Project Commands

| Command | Description | Options |
|---------|-------------|---------|
| `/prefix:project:changelog` | AI-powered CHANGELOG.md management that automatically determines version based on changes | `--analyze`, `--commit`, `--update-version` |
| `/prefix:project:create-command` | Create new slash commands from natural language descriptions | `description`, `of`, `what`, `you`, `want`, `the`, `command`, `to`, `do` |
| `/prefix:project:update-docs` | Intelligently updates project documentation based on code changes and implementation status | `--scope=<type>`, `--analyze`, `--commit` |
| `/prefix:project:update-hooks` | Update git hooks to the latest version in Claude command installations | `--all`, `--check-only` |

<!-- COMMANDS:END -->

## Maintaining Your Fork

Keeping your fork up-to-date and contributing back to the community ensures everyone benefits from improvements.

### Syncing with Upstream

1. **Add the upstream remote** (one-time setup)
   ```bash
   cd /path/to/your/fork
   git remote add upstream https://github.com/redpop/claude-code-slash-commands.git
   git remote -v  # Verify remotes
   ```

2. **Fetch and merge upstream changes**
   ```bash
   # Fetch upstream changes
   git fetch upstream
   
   # Merge into your main branch
   git checkout main
   git merge upstream/main
   
   # Push to your fork
   git push origin main
   ```

3. **Update your installations**
   ```bash
   # Update each installation
   cd ~/.claude/commands/myprefix
   git pull
   ```

### Contributing Back to Upstream

When you've created a useful command that could benefit the community:

1. **Ensure your command is general-purpose**
   - Remove any company-specific or proprietary logic
   - Use clear, descriptive naming
   - Include comprehensive documentation

2. **Create a feature branch**
   ```bash
   git checkout -b feature/new-command
   git add commands/category/new-command.md
   git commit -m "✨ feat: add new-command for X functionality"
   git push origin feature/new-command
   ```

3. **Submit a pull request**
   - Visit your fork on GitHub
   - Click "Compare & pull request"
   - Describe your command and its use cases
   - Reference any related issues

### Best Practices for Fork Management

1. **Organize Custom Commands**
   ```
   commands/
   ├── team/           # Team-specific commands
   ├── project/        # Project-specific commands
   ├── internal/       # Internal tools
   └── experimental/   # Commands under development
   ```

2. **Document Your Commands**
   - Always include frontmatter with `description` and `argument-hint`
   - Add usage examples in the command file
   - Update your fork's README with team-specific instructions

3. **Version Control Strategy**
   - Tag releases for your team (`v1.0.0-team`)
   - Maintain a CHANGELOG for your custom commands
   - Use semantic versioning for breaking changes

4. **Testing Commands**
   ```bash
   # Test in isolation
   ~/.claude/commands/test-prefix/
   
   # Validate command structure
   ./scripts/update-readme.sh
   ```

5. **Security Considerations**
   - Never commit sensitive data or credentials
   - Use environment variables for configuration
   - Review commands before sharing with your team

## Adding Custom Commands

1. Create a new folder under `commands/` for your category
2. Create a `.md` file with your command name
3. Write your command logic as a Markdown prompt

### Example structure for a new command:

```
# In original repository or fork
commands/
└── my-category/
    └── my-command.md

# Fork-specific organization
commands/
├── team/              # Team-specific commands
│   └── deploy.md     # Available as: /team:team:deploy
├── project/           # Project tools
│   └── setup.md      # Available as: /team:project:setup
└── my-category/       # General commands
    └── my-command.md  # Available as: /team:my-category:my-command
```

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
