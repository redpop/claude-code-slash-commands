---
description: Manages CHANGELOG.md entries following Keep a Changelog format with version management
argument-hint: <version> <change_type> <message> [--commit] [--update-version]
---

# Claude Command: Changelog

This command adds entries to your project's CHANGELOG.md file following the [Keep a Changelog](https://keepachangelog.com/) format and [Semantic Versioning](https://semver.org/) conventions.

## Usage

```
/changelog <version> <change_type> <message>
/changelog <version> <change_type> <message> --commit
/changelog <version> <change_type> <message> --update-version
/changelog <version> <change_type> <message> --commit --update-version
```

### Arguments

- `<version>`: Version number (e.g., "1.2.0", "2.0.0-beta.1", or "unreleased")
- `<change_type>`: One of: added, changed, deprecated, removed, fixed, security
- `<message>`: Description of the change (use quotes for multi-word messages)
- `--commit`: Automatically commit the changelog update
- `--update-version`: Update version in package files (package.json, pyproject.toml, etc.)

## Examples

```
/changelog 1.2.0 added "Support for WebSocket connections"
/changelog 2.0.0 changed "Redesigned authentication system" --commit
/changelog unreleased fixed "Memory leak in cache layer"
/changelog 1.3.0 security "Updated dependencies to patch CVE-2024-1234" --update-version --commit
```

## What This Command Does

1. **Validates Input**:
   - Ensures version follows semantic versioning format (X.Y.Z) or is "unreleased"
   - Validates change_type is one of the allowed types
   - Checks for proper quoting of multi-word messages

2. **Analyzes Project Structure**:
   - Detects project type based on presence of package files
   - Identifies version fields in:
     - `package.json` (Node.js)
     - `pyproject.toml` (Python)
     - `Cargo.toml` (Rust)
     - `pom.xml` (Java/Maven)
     - `build.gradle` (Java/Gradle)
     - `setup.py` (Python)
     - `__init__.py` with `__version__`

3. **Manages Changelog**:
   - Creates CHANGELOG.md if it doesn't exist with proper header
   - Finds or creates version section with today's date
   - Adds entry under appropriate change type with emoji prefix
   - Maintains proper formatting and structure

4. **Optional Actions**:
   - Updates version in detected package files (--update-version)
   - Commits changes with conventional commit message (--commit)

## Change Type Emojis

The command automatically prefixes entries with appropriate emojis:

- ✨ **Added**: New features
- 🔄 **Changed**: Changes in existing functionality
- ⚠️ **Deprecated**: Soon-to-be removed features
- 🗑️ **Removed**: Removed features
- 🐛 **Fixed**: Bug fixes
- 🔒 **Security**: Security vulnerability fixes

## Changelog Structure

The command maintains this structure:

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2024-01-15

### Added
- ✨ New feature description

### Changed
- 🔄 Modified functionality description

### Fixed
- 🐛 Bug fix description

## [1.1.0] - 2024-01-01
...
```

## Workflow Steps

1. **Parse and Validate Arguments**:
   - Extract version, change_type, and message
   - Validate semantic version format (unless "unreleased")
   - Ensure change_type is valid

2. **Check/Create Changelog**:
   - Look for CHANGELOG.md in project root
   - Create with standard header if missing
   - Read existing content for modification

3. **Process Version Section**:
   - For "unreleased": Add to [Unreleased] section
   - For specific version:
     - Check if version section exists
     - Create new section with current date if missing
     - Position correctly (newer versions first)

4. **Add Change Entry**:
   - Find or create change type subsection
   - Add entry with emoji prefix and message
   - Maintain alphabetical order within subsections

5. **Update Version Files** (if --update-version):
   - Detect package files in project
   - Update version fields appropriately
   - Validate JSON/TOML syntax after update

6. **Commit Changes** (if --commit):
   - Stage CHANGELOG.md and any updated package files
   - Create commit with message: `📝 docs: update changelog for v{version}`
   - Show commit status

## Best Practices

- **Semantic Versioning**:
  - MAJOR (X.0.0): Breaking changes
  - MINOR (0.X.0): New features, backwards compatible
  - PATCH (0.0.X): Bug fixes, backwards compatible

- **Clear Messages**:
  - Start with action verb (Add, Update, Fix, Remove)
  - Be specific about what changed
  - Reference issue numbers when applicable

- **Unreleased Section**:
  - Use for changes not yet in a release
  - Move entries to versioned section when releasing

- **Grouping Changes**:
  - Keep related changes together
  - Order by importance within sections

## Version Update Support

The command intelligently updates version in:

### Node.js (package.json)
```json
{
  "version": "1.2.0"
}
```

### Python (pyproject.toml)
```toml
[tool.poetry]
version = "1.2.0"

# or

[project]
version = "1.2.0"
```

### Python (setup.py)
```python
setup(
    version="1.2.0",
    ...
)
```

### Python (__init__.py)
```python
__version__ = "1.2.0"
```

### Rust (Cargo.toml)
```toml
[package]
version = "1.2.0"
```

### Java (pom.xml)
```xml
<version>1.2.0</version>
```

## Error Handling

The command handles:
- Missing CHANGELOG.md (creates new)
- Invalid version format (shows proper format)
- Invalid change type (lists valid options)
- File permission issues
- Malformed existing changelog (attempts repair)
- Version conflicts (warns user)

## Important Notes

- Always uses today's date for new version sections
- Preserves existing changelog formatting
- Maintains newlines and spacing conventions
- Creates backup before major modifications
- Validates all changes before writing
- For "unreleased" version, no date is added
- Emoji prefixes are added automatically
- Change types are case-insensitive in input
- Messages are automatically capitalized

## Integration with Git

When using `--commit`:
- Ensures git repository exists
- Checks for uncommitted changes
- Stages only changelog and version files
- Uses conventional commit format
- Shows git status after commit

## Examples of Generated Entries

### Simple Addition
```
/changelog 1.1.0 added "User authentication system"
```
Results in:
```markdown
### Added
- ✨ User authentication system
```

### Security Fix with Commit
```
/changelog 1.0.1 security "Patch XSS vulnerability in comment system" --commit
```
Results in:
```markdown
### Security
- 🔒 Patch XSS vulnerability in comment system
```

### Unreleased Feature
```
/changelog unreleased added "Dark mode support"
```
Results in:
```markdown
## [Unreleased]

### Added
- ✨ Dark mode support
```

### Version Update with Commit
```
/changelog 2.0.0 changed "Complete API redesign" --update-version --commit
```
Updates version in all package files and commits with message:
```
📝 docs: update changelog for v2.0.0
```