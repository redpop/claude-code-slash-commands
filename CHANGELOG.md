# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.8.0] - 2025-01-27

### Added

- ✨ Hybrid Sub-Agent Orchestration System - combines Task Tool parallelization with Claude Code Sub-Agents for 5-10x performance improvements
- ✨ 5 specialized Sub-Agents: security-specialist, performance-optimizer, test-engineer, code-architect, refactoring-expert
- ✨ Hybrid commands category - new command type that uses three-phase approach (scan, delegate, synthesize)
- ✨ Orchestration commands - 5 new parallel analysis commands (analyze-parallel, security-audit, refactor-impact, test-coverage, performance-scan)
- ✨ Research commands - 3 new research commands (deep-dive, codebase-map, dependency-trace)
- ✨ Create Sub-Agent helper script - allows easy creation of new specialized agents
- ✨ Agent templates - 3 templates for creating specialized, analyzer, and helper agents
- ✨ Hybrid command templates - templates for creating multi-phase analysis commands
- ✨ Extended documentation in docs/ directory - HYBRID-ARCHITECTURE.md and updated TECHNICAL-GUIDE.md

### Changed

- 🔄 Repository structure reorganized - documentation moved to docs/ directory
- 🔄 .claude-commands.json enhanced with hybrid mode configuration and agent registry
- 🔄 create-sub-agent-command.sh updated to support hybrid command creation
- 🔄 Commands now support both Task-based parallelization and Claude Code Sub-Agent delegation
- 🔄 Installation script updated to handle new agents directory structure

### Security

- 🔒 All commands translated from German to English for international usage
- 🔒 Enhanced configuration with performance modes (conservative, balanced, aggressive) for resource management

## [1.7.0] - 2025-01-26

### Added

- ✨ Comprehensive fork support - installation scripts now automatically detect and use fork URLs
- ✨ Repository configuration file (.claude-commands.json) for fork metadata
- ✨ GitHub Actions workflow for automatic fork setup and configuration
- ✨ Dynamic URL detection for multiple git platforms (GitHub, GitLab, Bitbucket)
- ✨ Fork synchronization workflow with upstream repository

### Changed

- 🔄 Installation script now dynamically detects repository URLs instead of using hardcoded values
- 🔄 Git hooks updated to version 5 with improved fork support
- 🔄 Commands updated to use dynamic URL references instead of hardcoded repository paths
- 🔄 README enhanced with comprehensive forking guide and best practices

### Fixed

- 🐛 Hardcoded repository URLs removed throughout the codebase for better fork flexibility

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

[1.8.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.6.1...v1.7.0
[1.6.1]: https://github.com/redpop/claude-code-slash-commands/compare/v1.6.0...v1.6.1
[1.6.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/redpop/claude-code-slash-commands/releases/tag/v1.1.0
