# GitHub Copilot Instructions for Reusable Workflows

## Project Overview

This repository contains reusable GitHub Actions workflows designed for consistent code quality, security scanning, and CI/CD automation across multiple projects. Workflows are called from other repositories using `workflow_call`.

## Language Conventions

Always use English (British) spelling and terminology unless necessary.

## Architecture Patterns

### Workflow Structure

- **Reusable Workflows**: All workflows use `workflow_call` trigger and are designed to be invoked from external repositories
- **Secret Convention**: Use `workflow_github_token` as the standard secret name for GitHub tokens
- **Permission Model**: Minimal permissions by default, with specific permissions granted per job
- **Tool Configurations**: Centralized in `.github/tool-configurations/` directory

### Security-First Approach

- **Action Pinning**: All GitHub Actions pinned to specific commit SHAs (not tags) for supply chain security
- **Multi-Layer Scanning**: Combines zizmor, grype, gitleaks, trufflehog, and trivy for comprehensive security coverage
- **SARIF Integration**: Security findings automatically uploaded to GitHub Security tab

## Development Workflow

### Local Development Commands

```bash
# Format code and check formatting
just prettier-check        # Check Prettier formatting
just prettier-format       # Apply Prettier formatting

# Justfile management
just format                # Format Justfile
just format-check          # Check Justfile formatting

# Security checks
just gitleaks-detect       # Run secret detection
just zizmor-check          # Check GitHub Actions security
just actionlint-check      # Lint workflow files

# Git hooks
just install-git-hooks     # Install pre-commit hooks
just prek-check            # Validate prek configuration
```

### Pre-commit Hooks

Automatic checks run on every commit:

- Secret detection (gitleaks)
- Code formatting (prettier)
- Justfile formatting
- Prek Check
- GitHub Actions security (zizmor)
- Workflow linting (actionlint)

### Tool Configuration Examples

**Pinact Configuration** (`.github/tool-configurations/pinact.yml`):

```yaml
ignore_actions:
  - name: "JackPlowman/reusable-workflows/.github/workflows/common-code-checks.yml"
    ref: "main"
```

**Workflow Pinning Pattern**:

```yaml
uses: actions/checkout@08c6903cd8c0fde910a37f88322edcfb5dd907a8 # v5.0.0
```

## Key Files and Directories

- `.github/workflows/` - Reusable workflow definitions
- `.github/tool-configurations/` - Configuration files for linting/security tools
- `Justfile` - Local development command orchestration
- `lefthook.yml` - Git hook configuration

## Integration Patterns

### Using Reusable Workflows

```yml
jobs:
  code-checks:
    uses: JackPlowman/reusable-workflows/.github/workflows/common-code-checks.yml@main
    secrets:
      workflow_github_token: ${{ secrets.GITHUB_TOKEN }}
```

### Permission Patterns

```yml
permissions:
  contents: read
  security-events: write # Required for SARIF uploads
  pull-requests: write # Required for PR comments
```

## Quality Assurance Stack

- **Markdown**: linkspector, markdownlint-cli2
- **YAML**: yamllint
- **GitHub Actions**: actionlint, zizmor, pinact
- **Security**: gitleaks, trufflehog, grype, trivy
- **Formatting**: prettier, editorconfig-checker
- **Build Tools**: just format checking

## Common Patterns

1. **Error Handling**: Use `continue-on-error: true` for non-blocking security scans
2. **Conditional Execution**: Check for config file existence before running tools
3. **Parallel Jobs**: Security scans run in parallel for efficiency
4. **Fetch Depth**: Use `fetch-depth: 0` for complete git history access
5. **Color Output**: Set `FORCE_COLOR: 1` environment variable for consistent terminal colors</content>
   <parameter name="filePath">/Users/jackplowman/projects/Personal/reusable-workflows/.github/copilot-instructions.md
