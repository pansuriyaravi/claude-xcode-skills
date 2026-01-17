# Claude Xcode Skills

Auto-validate Swift code changes by building after Claude finishes editing.

## What It Does

When Claude edits Swift files:
1. Tracks that Swift files were modified
2. When Claude finishes the task → auto-builds
3. Shows errors if any → Claude can fix them

**No manual commands needed** - fully automatic via hooks.

## Install

**Full install (skill + hooks):**
```bash
# Project level
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- project

# Global (all projects)
curl -sL https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills/main/install.sh | bash -s -- global
```

**Skill only (no auto-build):**
```bash
curl -sL .../install.sh | bash -s -- skill-only
```

**Hooks only (if you already have the skill):**
```bash
curl -sL .../install.sh | bash -s -- hooks-only
```

## Update

```bash
# Update project
curl -sL .../install.sh | bash -s -- update

# Update global
curl -sL .../install.sh | bash -s -- update-global

# Check version
curl -sL .../install.sh | bash -s -- version
```

## Uninstall

```bash
curl -sL .../install.sh | bash -s -- uninstall        # project
curl -sL .../install.sh | bash -s -- uninstall-global # global
```

## How It Works

```
┌────────────────────────────────────────────────┐
│  Claude editing Swift files                    │
│                                                │
│  Edit A.swift  ──► touch /tmp/.swift_edited   │
│  Edit B.swift  ──► touch /tmp/.swift_edited   │
│                                                │
│  Claude finishes ──► Stop hook triggers        │
│                      └─► Flag exists? Build!   │
│                          └─► Show errors       │
└────────────────────────────────────────────────┘
```

| Hook | When | Action |
|------|------|--------|
| `PostToolUse` | Each Swift edit | Mark flag file |
| `Stop` | Claude finishes | If flag → Build → Show result |

## What Gets Installed

```
.claude/
├── skills/xcode-build/
│   └── SKILL.md              # Skill instructions (~46 lines)
└── settings.local.json       # Hooks configuration
```

## Commands Reference

| Command | Description |
|---------|-------------|
| `project` | Install skill + hooks to project |
| `global` | Install skill + hooks globally |
| `skill-only` | Install only skill (no hooks) |
| `hooks-only` | Install only hooks |
| `update` | Update project installation |
| `update-global` | Update global installation |
| `uninstall` | Remove from project |
| `uninstall-global` | Remove globally |
| `version` | Show installed versions |

## License

MIT
