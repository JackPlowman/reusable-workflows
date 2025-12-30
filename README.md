# Reusable Workflows

A comprehensive collection of reusable GitHub Actions workflows for various development tasks, including code quality checks, security scanning, dependency management, and CI/CD automation. These workflows are designed to be easily integrated into any project to maintain consistent development standards across repositories.

## Table of Contents

- [Reusable Workflows](#reusable-workflows)
  - [Table of Contents](#table-of-contents)
  - [Available Workflows](#available-workflows)
  - [Usage](#usage)
    - [Basic Example](#basic-example)
  - [Workflow Details](#workflow-details)
    - [Common Code Checks](#common-code-checks)
    - [CodeQL Analysis](#codeql-analysis)
    - [Pull Request Tasks](#pull-request-tasks)
    - [Cache Management](#cache-management)
    - [Label Synchronization](#label-synchronization)
  - [Contributing](#contributing)
  - [Licence](#licence)

## Available Workflows

- **`common-code-checks.yml`** - Comprehensive code quality and security scanning
- **`codeql-analysis.yml`** - GitHub CodeQL security analysis for multiple languages
- **`common-pull-request-tasks.yml`** - Automated PR labelling, sizing, and dependency review
- **`common-clean-caches.yml`** - Automated GitHub Actions cache cleanup
- **`common-sync-labels.yml`** - Repository label synchronization and management

## Usage

### Basic Example

To use these workflows in your repository, create a workflow file in `.github/workflows/` and reference the desired reusable workflow:

```yaml
name: "Code Quality Checks"

on:
  push:
    branches: [main]
  pull_request:
    types: [opened, synchronize]

permissions:
  contents: read

jobs:
  code-checks:
    name: Code Quality & Security
    permissions:
      contents: read
      actions: read
      pull-requests: write
      security-events: write
    uses: JackPlowman/reusable-workflows/.github/workflows/common-code-checks.yml@main
    secrets:
      workflow_github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Workflow Details

### Common Code Checks

The `common-code-checks.yml` workflow provides comprehensive code quality and security scanning:

- **Markdown Link Validation** - Checks for broken links in documentation
- **Justfile Format Checking** - Validates Just command file formatting
- **Prek Check** - Validates Prek Git hooks configuration
- **Security Scanning**:
  - Pinact - Ensures GitHub Actions are pinned to specific versions
  - Zizmor - GitHub Actions security analysis
  - Grype - Vulnerability scanning
  - Gitleaks - Secret detection
  - TruffleHog - Advanced secret scanning
- **Code Quality**:
  - Actionlint - GitHub Actions workflow linting
  - EditorConfig - File format consistency checking

### CodeQL Analysis

Advanced security analysis supporting multiple programming languages:

```yaml
jobs:
  codeql-analysis:
    name: CodeQL Analysis
    permissions:
      actions: read
      contents: read
      security-events: write
    strategy:
      matrix:
        language: [javascript, python, go, java]
    uses: JackPlowman/reusable-workflows/.github/workflows/codeql-analysis.yml@main
    with:
      language: ${{ matrix.language }}
```

### Pull Request Tasks

Automated PR management including:

- **Smart Labelling** - Automatically labels PRs based on changed files
- **Size Labelling** - Adds size labels (XS, S, M, L, XL, XXL) based on changes
- **Dependency Review** - Security analysis of dependency changes

### Cache Management

Automated cleanup of GitHub Actions caches to optimize storage usage:

```yaml
uses: JackPlowman/reusable-workflows/.github/workflows/common-clean-caches.yml@main
secrets:
  workflow_github_token: ${{ secrets.GITHUB_TOKEN }}
```

### Label Synchronization

Maintains consistent repository labels across projects:

```yaml
uses: JackPlowman/reusable-workflows/.github/workflows/common-sync-labels.yml@main
secrets:
  workflow_github_token: ${{ secrets.GITHUB_TOKEN }}
```

## Contributing

We welcome contributions to improve these workflows! Please read the [Contributing Guidelines](docs/CONTRIBUTING.md) for more information.

## Licence

This project is licensed under the MIT Licence. See the [LICENCE](LICENCE) file for details.
