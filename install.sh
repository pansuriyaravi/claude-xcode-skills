#!/bin/bash

# Claude Xcode Skills Installer

set -e

VERSION="1.1.0"
REPO_URL="https://github.com/pansuriyaravi/claude-xcode-skills"
SKILL_NAME="xcode-build"
BASE_URL="https://raw.githubusercontent.com/pansuriyaravi/claude-xcode-skills"
BRANCH="${2:-main}"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

install_skill_project() {
    echo "Installing skill to .claude/skills/$SKILL_NAME/..."
    mkdir -p ".claude/skills/$SKILL_NAME"
    curl -sL "$BASE_URL/$BRANCH/skills/$SKILL_NAME/SKILL.md" -o ".claude/skills/$SKILL_NAME/SKILL.md"
    echo "$VERSION" > ".claude/skills/$SKILL_NAME/.version"
    echo -e "${GREEN}✓ Skill installed${NC}"
}

install_skill_global() {
    echo "Installing skill to ~/.claude/skills/$SKILL_NAME/..."
    mkdir -p ~/.claude/skills/$SKILL_NAME
    curl -sL "$BASE_URL/$BRANCH/skills/$SKILL_NAME/SKILL.md" -o ~/.claude/skills/$SKILL_NAME/SKILL.md
    echo "$VERSION" > ~/.claude/skills/$SKILL_NAME/.version
    echo -e "${GREEN}✓ Skill installed globally${NC}"
}

install_permissions_project() {
    echo "Installing permissions to .claude/settings.local.json..."

    SETTINGS_FILE=".claude/settings.local.json"
    mkdir -p .claude

    if [[ -f "$SETTINGS_FILE" ]]; then
        cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
        echo -e "${YELLOW}  Backed up existing settings to $SETTINGS_FILE.backup${NC}"
    fi

    curl -sL "$BASE_URL/$BRANCH/settings-template.json" -o /tmp/xcode-permissions.json

    if [[ -f "$SETTINGS_FILE" ]] && command -v jq &> /dev/null; then
        jq -s '.[0] * .[1]' "$SETTINGS_FILE.backup" /tmp/xcode-permissions.json > "$SETTINGS_FILE"
    else
        cp /tmp/xcode-permissions.json "$SETTINGS_FILE"
    fi

    rm /tmp/xcode-permissions.json
    echo -e "${GREEN}✓ Permissions installed${NC}"
}

install_permissions_global() {
    echo "Installing permissions to ~/.claude/settings.json..."

    SETTINGS_FILE=~/.claude/settings.json
    mkdir -p ~/.claude

    if [[ -f "$SETTINGS_FILE" ]]; then
        cp "$SETTINGS_FILE" "$SETTINGS_FILE.backup"
        echo -e "${YELLOW}  Backed up existing settings to $SETTINGS_FILE.backup${NC}"
    fi

    curl -sL "$BASE_URL/$BRANCH/settings-template.json" -o /tmp/xcode-permissions.json

    if [[ -f "$SETTINGS_FILE" ]] && command -v jq &> /dev/null; then
        jq -s '.[0] * .[1]' "$SETTINGS_FILE.backup" /tmp/xcode-permissions.json > "$SETTINGS_FILE"
    else
        cp /tmp/xcode-permissions.json "$SETTINGS_FILE"
    fi

    rm /tmp/xcode-permissions.json
    echo -e "${GREEN}✓ Permissions installed globally${NC}"
}

uninstall_project() {
    rm -rf ".claude/skills/$SKILL_NAME"
    echo "Removed skill from project."
    echo -e "${YELLOW}Note: Permissions in .claude/settings.local.json not removed (manual cleanup needed)${NC}"
}

uninstall_global() {
    rm -rf ~/.claude/skills/$SKILL_NAME
    echo "Removed skill globally."
    echo -e "${YELLOW}Note: Permissions in ~/.claude/settings.json not removed (manual cleanup needed)${NC}"
}

show_version() {
    echo "Claude Xcode Skills v$VERSION"
    echo ""
    echo "Project skill:"
    if [[ -f ".claude/skills/$SKILL_NAME/.version" ]]; then
        echo "  $(cat .claude/skills/$SKILL_NAME/.version)"
    else
        echo "  Not installed"
    fi
    echo ""
    echo "Global skill:"
    if [[ -f ~/.claude/skills/$SKILL_NAME/.version ]]; then
        echo "  $(cat ~/.claude/skills/$SKILL_NAME/.version)"
    else
        echo "  Not installed"
    fi
}

show_help() {
    echo "Claude Xcode Skills Installer v$VERSION"
    echo ""
    echo "Usage: install.sh <command> [branch/tag]"
    echo ""
    echo "Commands:"
    echo "  project        Install skill + permissions to project (.claude/)"
    echo "  global         Install skill + permissions globally (~/.claude/)"
    echo "  skill-only     Install only skill (no permissions) to project"
    echo "  update         Update project installation"
    echo "  update-global  Update global installation"
    echo "  uninstall      Remove from project"
    echo "  uninstall-global  Remove globally"
    echo "  version        Show installed versions"
    echo ""
    echo "Examples:"
    echo "  # Full install (skill + permissions)"
    echo "  curl -sL $REPO_URL/main/install.sh | bash -s -- project"
    echo ""
    echo "  # Update existing"
    echo "  curl -sL $REPO_URL/main/install.sh | bash -s -- update"
    echo ""
    echo "  # Skill only"
    echo "  curl -sL $REPO_URL/main/install.sh | bash -s -- skill-only"
    echo ""
    echo "Usage in Claude:"
    echo "  Run /xcode-build to validate Swift changes"
}

case "${1:-project}" in
    project)
        install_skill_project
        install_permissions_project
        echo ""
        echo -e "${GREEN}Done! Use /xcode-build in Claude to validate Swift changes.${NC}"
        ;;
    global)
        install_skill_global
        install_permissions_global
        echo ""
        echo -e "${GREEN}Done! Works in all iOS projects.${NC}"
        ;;
    skill-only)
        install_skill_project
        ;;
    skill-only-global)
        install_skill_global
        ;;
    update)
        install_skill_project
        install_permissions_project
        echo ""
        echo -e "${GREEN}Updated!${NC}"
        ;;
    update-global)
        install_skill_global
        install_permissions_global
        echo ""
        echo -e "${GREEN}Updated globally!${NC}"
        ;;
    uninstall)
        uninstall_project
        ;;
    uninstall-global)
        uninstall_global
        ;;
    version|-v|--version)
        show_version
        ;;
    help|*)
        show_help
        ;;
esac
