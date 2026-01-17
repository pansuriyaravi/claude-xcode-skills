# Claude Xcode Skills

Build and validate Swift/iOS code changes in Claude Code using `/xcode-build`.

## What It Does

When you run `/xcode-build` in Claude:
1. Detects your Xcode project/workspace
2. Finds an available iOS simulator (prefers iPhone 17 Pro)
3. Builds the project
4. Shows errors if any so Claude can fix them

## Install

```bash
# Project level
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- project

# Global (all projects)
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- global
```

**Skill only (no permissions):**
```bash
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- skill-only
```

## Usage

In Claude Code, run:
```
/xcode-build
```

Claude will build your project and report any errors.

## Update

```bash
# Update project
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- update

# Update global
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- update-global

# Check version
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- version
```

## Uninstall

```bash
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- uninstall        # project
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- uninstall-global # global
```

## What Gets Installed

```
.claude/
├── skills/xcode-build/
│   └── SKILL.md              # Skill instructions
└── settings.local.json       # Permissions for xcodebuild
```

## Commands Reference

| Command | Description |
|---------|-------------|
| `project` | Install skill + permissions to project |
| `global` | Install skill + permissions globally |
| `skill-only` | Install only skill (no permissions) |
| `update` | Update project installation |
| `update-global` | Update global installation |
| `uninstall` | Remove from project |
| `uninstall-global` | Remove globally |
| `version` | Show installed versions |

## License

MIT
