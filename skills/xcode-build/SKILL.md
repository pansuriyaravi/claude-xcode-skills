---
name: xcode-build
description: Validate Swift/iOS code changes by building. Use after editing Swift files to catch and fix compile errors.
allowed-tools: Bash, Read, Edit
---

# Xcode Build Check

After editing Swift files, build to validate changes and fix any errors.

## When to Use

- After editing `.swift` files
- After adding/removing imports
- After refactoring code

## Quick Build Check

```bash
# Find project (prefer workspace over project)
PROJECT=$(ls -d *.xcworkspace 2>/dev/null | head -1)
PROJECT_FLAG="-workspace"
if [[ -z "$PROJECT" ]]; then
  PROJECT=$(ls -d *.xcodeproj 2>/dev/null | head -1)
  PROJECT_FLAG="-project"
fi

# Get scheme
SCHEME=$(xcodebuild -list 2>/dev/null | grep -A1 "Schemes:" | tail -1 | xargs)

# Find available iOS simulator (prefer iPhone 17 Pro, fallback to any iPhone)
SIMULATOR=$(xcrun simctl list devices available | grep -E "iPhone 17 Pro" | head -1 | sed 's/.*(\([A-F0-9-]*\)).*/\1/')
if [[ -z "$SIMULATOR" ]]; then
  SIMULATOR=$(xcrun simctl list devices available | grep -E "iPhone" | head -1 | sed 's/.*(\([A-F0-9-]*\)).*/\1/')
fi

# Build using simulator ID
xcodebuild $PROJECT_FLAG "$PROJECT" -scheme "$SCHEME" \
  -destination "platform=iOS Simulator,id=$SIMULATOR" \
  -configuration Debug \
  ONLY_ACTIVE_ARCH=YES \
  build 2>&1 | tee /tmp/build.log

# Check result
grep -q "BUILD SUCCEEDED" /tmp/build.log && echo "OK" || grep -E "error:" /tmp/build.log | head -10
```

## On Error

1. Extract error details:
```bash
grep -E "\.swift:[0-9]+:" /tmp/build.log | head -5
```

2. Read the file at the error line
3. Fix the issue
4. Rebuild to verify
