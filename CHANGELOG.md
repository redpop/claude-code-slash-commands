# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.6.1] - 2025-01-26

### Fixed

- 🐛 Hook version detection bug - improved version extraction to avoid false matches in code

## [1.6.0] - 2025-01-26

### Added

- ✨ Update hooks command - allows updating git hooks to latest version in Claude command installations
- ✨ Custom repository URL support - installation script now respects CLAUDE_COMMANDS_REPO_URL environment variable

### Changed

- 🔄 Git commit command now uses generic pre-commit checks - removed pnpm-specific commands for broader compatibility

### Fixed

- 🐛 Shell script warning in update-hooks.sh - fixed trap command to use single quotes

## [1.5.0] - 2025-01-26

### Added

- ✨ Five Whys analysis command - implements root cause analysis methodology for systematic problem investigation

## [1.4.0] - 2025-01-26

### Added

- ✨ Create command meta-command - helps create new slash commands with proper structure and documentation

### Changed

- 🔄 Create command now uses AI-powered natural language processing - describe what you want and AI generates the complete command

## [1.3.0] - 2025-01-26

### Added

- ✨ Comprehensive documentation update slash command - intelligently updates project docs based on code changes
- ✨ Shellcheck command for automatic shell script fixing - analyzes and fixes shell script issues

### Fixed

- 🐛 Exclude CHANGELOG.md from command installations - prevents CHANGELOG from appearing in ~/.claude/commands directories

## [1.2.0] - 2025-01-26

### Added

- ✨ Push option for git commit command - allows automatic push after commit with `--push`

## [1.1.0] - 2025-01-26

### Added

- ✨ Git sparse checkout for installations - enables simple updates via 'git pull'

### Changed

- 🔄 Installation script now creates proper Git repositories instead of copying files
- 🔄 Update process simplified to use native Git commands

### Fixed

- 🐛 Update instructions in README now reflect actual Git-based workflow

[1.6.1]: https://github.com/redpop/claude-code-slash-commands/compare/v1.6.0...v1.6.1
[1.6.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/redpop/claude-code-slash-commands/releases/tag/v1.1.0
