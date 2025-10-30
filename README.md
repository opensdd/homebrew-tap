# homebrew-tap

Homebrew Tap for installing OpenSDD CLI (`osdd`)

## Installation

### Prerequisites
- [Homebrew](https://brew.sh/) installed on macOS or Linux

### Install via Homebrew Tap

```bash
# Add the opensdd tap
brew tap opensdd/tap

# Install osdd CLI
brew install osdd

# Verify installation
osdd version
```

### Important Note

The `osdd` formula depends on releases being published to the [opensdd/osdd-cli](https://github.com/opensdd/osdd-cli) repository. If no releases are available yet, the formula cannot be installed. Check the [osdd-cli releases page](https://github.com/opensdd/osdd-cli/releases) to see available versions.

## Usage

Once installed, you can use the `osdd` CLI:

```bash
# Display version information
osdd version

# Show help and available commands
osdd --help
```

For detailed usage instructions, see the [osdd-cli documentation](https://github.com/opensdd/osdd-cli).

## Updating the Formula

When a new version of `osdd` is released, the formula needs to be updated to point to the new release. This is done via an automated GitHub Actions workflow.

### Triggering the Workflow

1. Navigate to the [Actions tab](https://github.com/opensdd/homebrew-tap/actions/workflows/bump-formula.yml)
2. Click **"Run workflow"**
3. Enter the version number in one of these formats:
   - `v1.2.3` (with 'v' prefix)
   - `1.2.3` (without 'v' prefix)
4. Click **"Run workflow"**

### What the Workflow Does

The bump-formula workflow automatically:

1. **Validates** the version format (semantic versioning)
2. **Normalizes** the version (adds 'v' prefix if missing)
3. **Checks** that the release exists in opensdd/osdd-cli
4. **Downloads** the appropriate macOS release asset
5. **Computes** the SHA256 checksum
6. **Updates** Formula/osdd.rb with the new URL and checksum
7. **Validates** the formula syntax
8. **Creates** a pull request with the changes

### Required Permissions

The workflow uses GitHub's built-in `GITHUB_TOKEN` which has the following permissions:
- `contents:write` - To commit formula updates and push branches
- `pull-requests:write` - To create pull requests for review

No additional secrets or configuration are required.

### Repository Policy

Formula updates are submitted as **pull requests** (not direct commits) for safety and review. This ensures:

- Changes can be reviewed before merging
- Automated checks can validate the formula
- Easy rollback if issues arise
- Audit trail for all version changes

After the PR is created, a maintainer should:
1. Review the changes
2. Verify the release exists and is correct
3. Merge the PR to make the update available

## Troubleshooting

### Formula installation fails

**Problem**: `brew install osdd` fails with download or checksum errors

**Solutions**:
- Verify the release exists: https://github.com/opensdd/osdd-cli/releases
- Check that the formula URL and SHA256 are correct in `Formula/osdd.rb`
- Update Homebrew: `brew update`
- Try reinstalling: `brew uninstall osdd && brew install osdd`

### Workflow fails with "Release not found"

**Problem**: The bump workflow fails saying the release doesn't exist

**Solutions**:
- Ensure the version tag exists in [opensdd/osdd-cli releases](https://github.com/opensdd/osdd-cli/releases)
- Check that the version format matches the release tag (with or without 'v' prefix)
- Verify the release is published (not just a draft)

### Workflow fails with "Asset not found"

**Problem**: The workflow can't find a suitable macOS asset in the release

**Solutions**:
- Verify the release includes macOS tarball assets (`.tar.gz` files)
- Expected asset naming patterns:
  - `osdd-darwin-arm64.tar.gz` (Apple Silicon)
  - `osdd-darwin-amd64.tar.gz` (Intel Mac)
  - `osdd-darwin.tar.gz` or `osdd-macos.tar.gz` (universal)
- Check that assets are properly uploaded to the GitHub release

### Checksum mismatch during installation

**Problem**: Homebrew reports a SHA256 checksum mismatch

**Solutions**:
- The formula's SHA256 may be outdated or incorrect
- Run the bump-formula workflow to refresh the checksum
- Verify the release asset hasn't been modified or re-uploaded
- Report an issue if the problem persists

### Version validation fails

**Problem**: The workflow rejects the version input

**Solutions**:
- Ensure the version follows semantic versioning: `MAJOR.MINOR.PATCH`
- Valid formats: `v1.2.3`, `1.2.3`, `v1.0.0-beta.1`, `1.0.0+build.123`
- Invalid formats: `1.2`, `v1`, `latest`, `1.2.3.4`

## Local Testing

### Test Formula Syntax

```bash
# Validate Ruby syntax
ruby -c Formula/osdd.rb
```

### Test Formula Installation (requires osdd-cli releases)

```bash
# Install from local formula file
brew install --build-from-source ./Formula/osdd.rb

# Verify installation
osdd version

# Uninstall
brew uninstall osdd
```

### Test Formula from PR Branch

```bash
# Install directly from a PR branch (replace BRANCH_NAME)
brew install --build-from-source https://raw.githubusercontent.com/opensdd/homebrew-tap/BRANCH_NAME/Formula/osdd.rb
```

## Development

### Repository Structure

```
.
├── Formula/
│   └── osdd.rb              # Homebrew formula for osdd CLI
├── .github/
│   └── workflows/
│       └── bump-formula.yml # Automated formula update workflow
├── README.md                # This file
└── LICENSE                  # MIT License
```

### Formula Structure

The `Formula/osdd.rb` file follows Homebrew's formula conventions:

- **Class name**: `Osdd` (CamelCase)
- **Filename**: `osdd.rb` (lowercase)
- **URL**: Points to GitHub Release tarball
- **SHA256**: Checksum for integrity verification
- **Install block**: Installs the `osdd` binary to Homebrew's bin directory
- **Test block**: Validates the installation by running `osdd version`

### Making Changes

To manually update the formula:

1. Edit `Formula/osdd.rb`
2. Update the `url` to point to the new release
3. Download the release asset and compute its SHA256:
   ```bash
   curl -L -o osdd.tar.gz https://github.com/opensdd/osdd-cli/releases/download/v1.0.0/osdd-darwin-amd64.tar.gz
   shasum -a 256 osdd.tar.gz
   ```
4. Update the `sha256` field with the computed checksum
5. Validate syntax: `ruby -c Formula/osdd.rb`
6. Test installation: `brew install --build-from-source ./Formula/osdd.rb`
7. Create a PR with your changes

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

### Reporting Issues

If you encounter problems:

1. Check the [Troubleshooting](#troubleshooting) section
2. Search [existing issues](https://github.com/opensdd/homebrew-tap/issues)
3. Create a new issue with:
   - Your operating system and version
   - Homebrew version (`brew --version`)
   - The error message or unexpected behavior
   - Steps to reproduce

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Related Projects

- [opensdd/osdd-cli](https://github.com/opensdd/osdd-cli) - The OpenSDD CLI tool
- [Homebrew](https://brew.sh/) - The package manager for macOS and Linux
