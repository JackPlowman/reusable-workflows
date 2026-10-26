# ------------------------------------------------------------------------------
# Prettier
# ------------------------------------------------------------------------------

# Check all files with prettier
prettier-check:
    prettier . --check

# Format all files with prettier
prettier-format:
    prettier . --check --write

# ------------------------------------------------------------------------------
# Justfile
# ------------------------------------------------------------------------------

# Format Justfile
format:
    just --fmt --unstable

# Check Justfile formatting
format-check:
    just --fmt --check --unstable

# ------------------------------------------------------------------------------
# Gitleaks
# ------------------------------------------------------------------------------

# Run gitleaks detection
gitleaks-detect:
    gitleaks detect --source .

# ------------------------------------------------------------------------------
# Prek
# ------------------------------------------------------------------------------

# Validate the repository's prek configuration
prek-check:
    prek validate-config .pre-commit-config.yaml

# ------------------------------------------------------------------------------
# Zizmor
# ------------------------------------------------------------------------------

# Run zizmor checking
zizmor-check:
    uvx zizmor . --persona=auditor

# ------------------------------------------------------------------------------
# Pinact
# ------------------------------------------------------------------------------

export pinact_config := "-c .github/tool-configurations/pinact.yml"

# Run pinact
pinact-run:
    pinact run ${pinact_config}

# Run pinact checking
pinact-check:
    pinact run ${pinact_config} --verify --check

# Run pinact update
pinact-update:
    pinact run ${pinact_config} --update

# ------------------------------------------------------------------------------
# EditorConfig
# ------------------------------------------------------------------------------

# Check files format with EditorConfig
editorconfig-check:
    editorconfig-checker

# ------------------------------------------------------------------------------
# Git Hooks
# ------------------------------------------------------------------------------

# Install git hooks using prek
install-git-hooks:
    prek install

# ------------------------------------------------------------------------------
# Prek
# ------------------------------------------------------------------------------

# Update prek hooks and additional dependencies
prek-update:
    just prek-update-hooks
    just prek-update-additional-dependencies

# Prek update hooks
prek-update-hooks:
    prek update --freeze

prek-update-additional-dependencies:
    uv run --script https://raw.githubusercontent.com/JackPlowman/update-prek-additional-dependencies/refs/heads/main/update_prek_additional_dependencies.py

# ------------------------------------------------------------------------------
# Update All Tools
# ------------------------------------------------------------------------------

# Update all tools
update:
    just pinact-update
    just prek-update
