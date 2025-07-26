# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[1.3.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/redpop/claude-code-slash-commands/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/redpop/claude-code-slash-commands/releases/tag/v1.1.0
