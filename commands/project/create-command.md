---
description: Create new slash commands with proper structure and documentation
argument-hint: [command-name] [--category=<category>] [--update-readme]
---

# Claude Command: Create Command

This meta-command helps you create new slash commands for this repository by guiding you through the creation process and ensuring proper structure and documentation.

## Usage

```
/create-command                              # Interactive mode - guides through creation
/create-command my-awesome-tool              # Create with suggested name
/create-command --category=git               # Pre-select category
/create-command my-tool --update-readme      # Auto-update README after creation
```

### Arguments

- `command-name`: Optional name for the new command (lowercase with hyphens)
- `--category=<category>`: Pre-select command category (git, project, code, ai, etc.)
- `--update-readme`: Automatically run update-readme.sh after creation

## What This Command Does

1. **Interactive Command Creation**:
   - Asks for command name if not provided
   - Helps determine appropriate category
   - Gathers command description and purpose
   - Collects argument specifications
   - Builds comprehensive command documentation

2. **Category Selection**:
   - Lists existing categories from `commands/` directory
   - Suggests appropriate category based on command purpose
   - Allows creation of new categories if needed
   - Ensures consistent organization

3. **Template Generation**:
   - Creates properly formatted markdown file
   - Includes required YAML frontmatter
   - Adds standard sections based on command type
   - Follows repository conventions

4. **Documentation Update**:
   - Optionally runs `./scripts/update-readme.sh`
   - Ensures README reflects new command
   - Maintains alphabetical ordering
   - Preserves existing documentation

## Command Categories

### Existing Categories
- **git**: Version control operations (commit, branch, merge)
- **project**: Project management (changelog, documentation, setup)
- **code**: Code quality and analysis (shellcheck, lint, format)
- **ai**: AI-assisted tasks (handoff, review, generate)

### Creating New Categories
New categories should be:
- Lowercase, single word preferred
- Descriptive of command group
- Consistent with existing patterns
- Created only when necessary

## Interactive Workflow

### Step 1: Command Name
```
🎯 What should the new command be called?
Enter command name (lowercase-with-hyphens): analyze-dependencies
```

### Step 2: Category Selection
```
📁 Select or create a category:

Existing categories:
1. git - Version control commands
2. project - Project management commands
3. code - Code quality commands
4. ai - AI-assisted commands

Enter number or new category name: code
```

### Step 3: Command Description
```
📝 Provide a brief description (for README):
Description: Analyze and visualize project dependencies
```

### Step 4: Argument Specification
```
🔧 Does this command accept arguments? (y/n): y

Argument hint (e.g., [--flag] [path]): [--tree] [--outdated] [--security]
```

### Step 5: Command Purpose
```
🎯 What is the main purpose of this command?

1. Analysis/Reporting - Gather information and generate reports
2. Code Modification - Make changes to files
3. Workflow Automation - Orchestrate multiple steps
4. Development Tool - Assist with development tasks
5. Other - Custom purpose

Select purpose (1-5): 1
```

### Step 6: Template Generation
Based on selections, generates appropriate template with:
- Frontmatter metadata
- Usage examples
- Workflow steps
- Best practices
- Error handling

## Template Structure

### Basic Template
```markdown
---
description: {description}
argument-hint: {argument_hint}
---

# Claude Command: {command_title}

{detailed_description}

## Usage

```
/{prefix}:{category}:{command}
```

## What This Command Does

1. **Step 1**: Description
2. **Step 2**: Description
3. **Step 3**: Description

## Workflow Steps

### 1. Initialization
- Verify prerequisites
- Gather parameters
- Validate environment

### 2. Execution
- Main command logic
- Process results
- Handle errors

### 3. Reporting
- Generate output
- Provide recommendations
- Suggest next steps

## Best Practices

- Practice 1
- Practice 2
- Practice 3

## Error Handling

The command handles:
- Common error scenario 1
- Common error scenario 2
- Edge cases

## Important Notes

- Note about behavior
- Integration details
- Limitations
```

### Analysis Command Template
Includes additional sections:
- Data Collection Methods
- Report Format
- Visualization Options
- Export Capabilities

### Modification Command Template
Includes additional sections:
- File Discovery
- Backup Strategy
- Validation Steps
- Rollback Procedures

### Workflow Command Template
Includes additional sections:
- Phase Descriptions
- Dependency Management
- Progress Tracking
- Integration Points

## Examples

### Example 1: Creating a Git Command
```
/create-command git-sync --category=git

Creates: commands/git/git-sync.md
Purpose: Synchronize local and remote branches
```

### Example 2: Creating an Analysis Tool
```
/create-command dependency-check

Interactive flow:
- Category: code
- Description: Analyze and report on project dependencies
- Arguments: [--tree] [--outdated] [--security]
- Purpose: Analysis/Reporting
```

### Example 3: Creating a New Category
```
/create-command test-runner

When prompted for category, enter: testing
Creates: commands/testing/test-runner.md
```

## Post-Creation Steps

After creating a command:

1. **Review Generated File**:
   - Check `commands/{category}/{command}.md`
   - Verify frontmatter is correct
   - Ensure description is clear

2. **Customize Template**:
   - Add specific implementation details
   - Include relevant examples
   - Document edge cases

3. **Update Documentation**:
   - Run `./scripts/update-readme.sh` (or use --update-readme)
   - Verify command appears in README
   - Check formatting is correct

4. **Test Command**:
   - Install locally for testing
   - Verify command executes properly
   - Test with various arguments

## Integration with Repository

### File Structure
```
commands/
├── {category}/
│   └── {command}.md
```

### Naming Conventions
- Commands: `lowercase-with-hyphens`
- Categories: `lowercase` (single word preferred)
- No prefixes in filenames (added during installation)

### Documentation Standards
- Clear, actionable descriptions
- Comprehensive usage examples
- Detailed workflow steps
- Error handling documentation
- Best practices section

## Advanced Features

### Template Customization
The command adapts templates based on:
- Command purpose and type
- Argument complexity
- Category conventions
- Existing patterns in category

### Smart Suggestions
- Suggests categories based on command name
- Recommends argument patterns
- Proposes workflow structures
- Identifies similar existing commands

### Validation
- Checks for duplicate command names
- Validates category names
- Ensures proper markdown format
- Verifies frontmatter structure

## Error Handling

The command handles:
- **Duplicate commands**: Warns if command already exists
- **Invalid names**: Ensures lowercase-with-hyphens format
- **Missing directories**: Creates category directory if needed
- **Update script failures**: Reports issues with update-readme.sh
- **Invalid frontmatter**: Validates YAML syntax
- **File permissions**: Handles write permission issues

## Best Practices

### Command Design
1. **Single Purpose**: Each command should do one thing well
2. **Clear Naming**: Use descriptive, action-oriented names
3. **Consistent Arguments**: Follow repository patterns
4. **Comprehensive Docs**: Include all necessary information

### Category Organization
1. **Logical Grouping**: Commands with similar purposes
2. **Avoid Proliferation**: Reuse existing categories when possible
3. **Clear Boundaries**: Distinct purpose for each category

### Documentation Quality
1. **User-Focused**: Write for the end user
2. **Complete Examples**: Show real usage scenarios
3. **Error Guidance**: Help users troubleshoot
4. **Maintenance Notes**: Include update/modification hints

## Important Notes

- Generated commands follow repository conventions automatically
- Templates are starting points - customize for specific needs
- The `$ARGUMENTS` placeholder receives user input after command invocation
- All paths in the command file should use the prefix placeholder
- Remember to test commands after creation
- Use --update-readme flag for automatic documentation updates
- Commands should be self-contained with all necessary context
- Follow existing patterns in the target category
- Consider CI/CD integration when designing commands