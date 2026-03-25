#!/usr/bin/env bash
set -euo pipefail

# ─── Colors ───────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

# ─── Helpers ──────────────────────────────────────────────────────────────────
print_header() {
  echo ""
  echo -e "${BLUE}${BOLD}$1${RESET}"
  echo -e "${DIM}$(printf '%.0s─' $(seq 1 ${#1}))${RESET}"
}

print_step() {
  echo -e "  ${GREEN}✓${RESET} $1"
}

print_warn() {
  echo -e "  ${YELLOW}!${RESET} $1"
}

print_error() {
  echo -e "  ${RED}✗${RESET} $1"
}

# Holds the zero-indexed result of the most recent ask_choice call.
CHOICE_IDX=0

ask_choice() {
  local prompt="$1"
  shift
  local options=("$@")
  echo ""
  echo -e "${CYAN}${prompt}${RESET}"
  for i in "${!options[@]}"; do
    echo -e "  ${BOLD}$((i + 1)))${RESET} ${options[$i]}"
  done
  while true; do
    read -rp "  Choice [1-${#options[@]}]: " choice
    if [[ "$choice" =~ ^[0-9]+$ ]] && (( choice >= 1 && choice <= ${#options[@]} )); then
      CHOICE_IDX=$((choice - 1))
      return 0
    fi
    echo -e "  ${RED}Enter a number between 1 and ${#options[@]}${RESET}"
  done
}

# Maps a CLI flag string (e.g., "claude-code") to its position in an options
# array, enabling non-interactive mode to bypass ask_choice. Prints the index
# to stdout and returns 0 on match, returns 1 if not found.
resolve_flag() {
  local value="$1"; shift
  local options=("$@")
  for i in "${!options[@]}"; do
    if [[ "${options[$i]}" == "$value" ]]; then
      echo "$i"
      return 0
    fi
  done
  return 1
}

# Resolves a single integration category: uses the CLI flag if provided,
# otherwise prompts interactively. Sets CHOICE_IDX to the selected index.
#
# Usage: ask_or_resolve "flag_value" "flag_name" "header" "prompt" OPTIONS_ARRAY INTERACTIVE_LABELS
#   flag_value:          value from CLI flag (empty string if not provided)
#   flag_name:           flag name for error messages (e.g., "--tool")
#   header:              section header text (e.g., "AI Tool")
#   prompt:              interactive prompt text
#   remaining args:      option values (used for both flag resolution and interactive display)
#   INTERACTIVE_OVERRIDES: set this array before calling to use different labels in the interactive menu
ask_or_resolve() {
  local flag_value="$1" flag_name="$2" header="$3" prompt="$4"
  shift 4
  local options=("$@")

  if [[ -n "$flag_value" ]]; then
    if ! CHOICE_IDX=$(resolve_flag "$flag_value" "${options[@]}"); then
      echo "Invalid ${flag_name} value: $flag_value (options: ${options[*]})"
      exit 1
    fi
  else
    print_header "$header"
    if [[ ${#INTERACTIVE_OVERRIDES[@]} -gt 0 ]]; then
      ask_choice "$prompt" "${INTERACTIVE_OVERRIDES[@]}"
    else
      ask_choice "$prompt" "${options[@]}"
    fi
  fi
}

# ─── CLI Flag Parsing ─────────────────────────────────────────────────────────
# Supports non-interactive mode:
#   ./setup.sh --tool claude-code --notes markdown --tasks todo-md \
#              --calendar none --chat none --auth byok

FLAG_TOOL=""
FLAG_NOTES=""
FLAG_TASKS=""
FLAG_CALENDAR=""
FLAG_CHAT=""
FLAG_AUTH=""

show_help() {
  cat << 'HELPEOF'
AI Workflow Kit — Setup

Usage: ./setup.sh [options]

Run without options for interactive mode.

Options:
  --tool       AI tool: claude-code, cursor, codex, other
  --notes      Notes app: notion, obsidian, markdown, none
  --tasks      Task tracker: jira, linear, github-issues, todo-md, none
  --calendar   Calendar: google-calendar, apple-calendar, none
  --chat       Team chat: slack, discord, none
  --auth       Auth method: zapier-sdk, byok
  --help       Show this help message

Example (non-interactive):
  ./setup.sh --tool claude-code --notes markdown --tasks todo-md \
             --calendar none --chat none --auth byok
HELPEOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) show_help ;;
    --tool) FLAG_TOOL="$2"; shift 2 ;;
    --notes) FLAG_NOTES="$2"; shift 2 ;;
    --tasks) FLAG_TASKS="$2"; shift 2 ;;
    --calendar) FLAG_CALENDAR="$2"; shift 2 ;;
    --chat) FLAG_CHAT="$2"; shift 2 ;;
    --auth) FLAG_AUTH="$2"; shift 2 ;;
    *) echo "Unknown option: $1 (try --help)"; exit 1 ;;
  esac
done

# ─── Welcome ──────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}AI Workflow Kit — Setup${RESET}"
echo -e "${DIM}Configures skills for your AI tool, integrations, and workflow.${RESET}"
echo -e "${DIM}Takes about 2 minutes. You can re-run this anytime.${RESET}"

# ─── AI Tool ──────────────────────────────────────────────────────────────────
AI_TOOLS=("claude-code" "cursor" "codex" "other")
AI_LABELS=("Claude Code" "Cursor" "Codex CLI" "Other")
INTERACTIVE_OVERRIDES=("Claude Code" "Cursor" "Codex CLI" "Other (Windsurf, Cline, Aider, etc.)")
ask_or_resolve "$FLAG_TOOL" "--tool" "AI Tool" "Which AI coding assistant do you use?" "${AI_TOOLS[@]}"
INTERACTIVE_OVERRIDES=()
AI_TOOL="${AI_TOOLS[$CHOICE_IDX]}"
AI_LABEL="${AI_LABELS[$CHOICE_IDX]}"

# ─── Notes ────────────────────────────────────────────────────────────────────
NOTES_OPTIONS=("notion" "obsidian" "markdown" "none")
NOTES_LABELS=("Notion" "Obsidian" "Markdown (local)" "None")
INTERACTIVE_OVERRIDES=("Notion" "Obsidian" "Plain markdown (local files)" "Other / None")
ask_or_resolve "$FLAG_NOTES" "--notes" "Notes" "Where do you keep notes?" "${NOTES_OPTIONS[@]}"
INTERACTIVE_OVERRIDES=()
NOTES="${NOTES_OPTIONS[$CHOICE_IDX]}"
NOTES_LABEL="${NOTES_LABELS[$CHOICE_IDX]}"

# ─── Tasks ────────────────────────────────────────────────────────────────────
TASKS_OPTIONS=("jira" "linear" "github-issues" "todo-md" "none")
TASKS_LABELS=("Jira" "Linear" "GitHub Issues" "TODO.md (local)" "None")
INTERACTIVE_OVERRIDES=("Jira" "Linear" "GitHub Issues" "TODO.md (local file)" "Other / None (Todoist, Asana, etc.)")
ask_or_resolve "$FLAG_TASKS" "--tasks" "Tasks" "Where do you track tasks?" "${TASKS_OPTIONS[@]}"
INTERACTIVE_OVERRIDES=()
TASKS="${TASKS_OPTIONS[$CHOICE_IDX]}"
TASKS_LABEL="${TASKS_LABELS[$CHOICE_IDX]}"

# ─── Calendar ─────────────────────────────────────────────────────────────────
CALENDAR_OPTIONS=("google-calendar" "apple-calendar" "none")
CALENDAR_LABELS=("Google Calendar" "Apple Calendar" "None")
INTERACTIVE_OVERRIDES=("Google Calendar" "Apple Calendar" "Other / None")
ask_or_resolve "$FLAG_CALENDAR" "--calendar" "Calendar" "Which calendar do you use?" "${CALENDAR_OPTIONS[@]}"
INTERACTIVE_OVERRIDES=()
CALENDAR="${CALENDAR_OPTIONS[$CHOICE_IDX]}"
CALENDAR_LABEL="${CALENDAR_LABELS[$CHOICE_IDX]}"

# ─── Chat ─────────────────────────────────────────────────────────────────────
CHAT_OPTIONS=("slack" "discord" "none")
CHAT_LABELS=("Slack" "Discord" "None")
INTERACTIVE_OVERRIDES=("Slack" "Discord" "Other / None (Teams, etc.)")
ask_or_resolve "$FLAG_CHAT" "--chat" "Chat" "Which team chat do you use?" "${CHAT_OPTIONS[@]}"
INTERACTIVE_OVERRIDES=()
CHAT="${CHAT_OPTIONS[$CHOICE_IDX]}"
CHAT_LABEL="${CHAT_LABELS[$CHOICE_IDX]}"

# ─── Auth ─────────────────────────────────────────────────────────────────────
AUTH_OPTIONS=("zapier-sdk" "byok")
AUTH_LABELS=("Zapier SDK" "Bring Your Own Keys")

INTERACTIVE_OVERRIDES=("Zapier SDK (recommended)" "Bring your own API keys")
if [[ -z "$FLAG_AUTH" ]]; then
  print_header "Authentication"
  echo -e "  ${DIM}Zapier SDK connects to 7,000+ apps with one login.${RESET}"
  echo -e "  ${DIM}Or bring your own API keys for each service.${RESET}"
  ask_choice "How do you want to authenticate?" "${INTERACTIVE_OVERRIDES[@]}"
else
  if ! CHOICE_IDX=$(resolve_flag "$FLAG_AUTH" "${AUTH_OPTIONS[@]}"); then
    echo "Invalid --auth value: $FLAG_AUTH (options: ${AUTH_OPTIONS[*]})"
    exit 1
  fi
fi
INTERACTIVE_OVERRIDES=()
AUTH="${AUTH_OPTIONS[$CHOICE_IDX]}"
AUTH_LABEL="${AUTH_LABELS[$CHOICE_IDX]}"

# ─── Generate integrations/active.md ─────────────────────────────────────────
print_header "Generating configuration"

ACTIVE_FILE="${REPO_DIR}/integrations/active.md"

cat > "$ACTIVE_FILE" << ACTIVEEOF
# Active Integrations

<!-- Generated by setup.sh on $(date +%Y-%m-%d). Re-run ./setup.sh to reconfigure. -->

## AI Tool: ${AI_LABEL}

ACTIVEEOF

case "$AI_TOOL" in
  claude-code)
    echo 'Skills are symlinked to `~/.claude/commands/`.' >> "$ACTIVE_FILE"
    ;;
  cursor)
    echo 'Skills are copied to `.cursor/rules/` as `.mdc` files.' >> "$ACTIVE_FILE"
    ;;
  codex)
    echo 'Skills are referenced in `AGENTS.md`.' >> "$ACTIVE_FILE"
    ;;
  other)
    echo 'Manual setup — copy skill markdown into your system prompt.' >> "$ACTIVE_FILE"
    ;;
esac

cat >> "$ACTIVE_FILE" << ACTIVEEOF

## Auth: ${AUTH_LABEL}

ACTIVEEOF

if [[ "$AUTH" == "zapier-sdk" ]]; then
  cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
Uses the Zapier MCP server for unified API access.
Connection: `mcp__zapier-sdk`

ACTIVEEOF
else
  cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
Direct API keys. Set environment variables for each service.
See the README for required variables per integration.

ACTIVEEOF
fi

echo "---" >> "$ACTIVE_FILE"
echo "" >> "$ACTIVE_FILE"

# Notes section
if [[ "$NOTES" != "none" ]]; then
  cat >> "$ACTIVE_FILE" << ACTIVEEOF
## Notes: ${NOTES_LABEL}

ACTIVEEOF
  case "$NOTES" in
    notion)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Notion MCP or Notion REST API
- **Daily page database ID**: `[your-database-id]`
- **Journal database ID**: `[your-database-id]`
- **How skills use it**: Morning kickoff creates daily pages, EOD review updates them, journal appends entries

ACTIVEEOF
      ;;
    obsidian)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **Vault path**: `~/Documents/vault`
- **Daily notes folder**: `daily/`
- **How skills use it**: Morning kickoff creates daily notes, journal appends to daily file

ACTIVEEOF
      ;;
    markdown)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **Base path**: `~/.ai-workflow/`
- **Daily notes**: `~/.ai-workflow/daily/YYYY-MM-DD.md`
- **Journal**: `~/.ai-workflow/journal/YYYY-MM-DD.md`
- **How skills use it**: Skills create and append to local markdown files

ACTIVEEOF
      ;;
  esac
fi

# Tasks section
if [[ "$TASKS" != "none" ]]; then
  cat >> "$ACTIVE_FILE" << ACTIVEEOF
## Tasks: ${TASKS_LABEL}

ACTIVEEOF
  case "$TASKS" in
    jira)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Atlassian MCP or Jira REST API
- **Project key**: `[YOUR-PROJECT]`
- **Base URL**: `https://[yourorg].atlassian.net`
- **How skills use it**: Morning kickoff pulls sprint tasks, standup references work items

ACTIVEEOF
      ;;
    linear)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Linear API or Linear MCP
- **Team key**: `[YOUR-TEAM]`
- **How skills use it**: Morning kickoff pulls active issues, standup references current cycle

ACTIVEEOF
      ;;
    github-issues)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: GitHub CLI (`gh`) or GitHub REST API
- **Repository**: `[owner/repo]`
- **How skills use it**: Morning kickoff pulls assigned issues, todo creates new issues

ACTIVEEOF
      ;;
    todo-md)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **File**: `~/.ai-workflow/todos.md`
- **How skills use it**: Todo skill appends to file, morning kickoff reads open items

ACTIVEEOF
      ;;
  esac
fi

# Calendar section
if [[ "$CALENDAR" != "none" ]]; then
  cat >> "$ACTIVE_FILE" << ACTIVEEOF
## Calendar: ${CALENDAR_LABEL}

ACTIVEEOF
  case "$CALENDAR" in
    google-calendar)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Google Calendar via Zapier SDK or direct API
- **Calendar ID**: `[your@email.com]`
- **How skills use it**: Morning kickoff shows today's meetings, meeting-prep gathers context

ACTIVEEOF
      ;;
    apple-calendar)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: AppleScript or `icalBuddy` CLI
- **How skills use it**: Morning kickoff shows today's meetings via local calendar queries

ACTIVEEOF
      ;;
  esac
fi

# Chat section
if [[ "$CHAT" != "none" ]]; then
  cat >> "$ACTIVE_FILE" << ACTIVEEOF
## Chat: ${CHAT_LABEL}

ACTIVEEOF
  case "$CHAT" in
    slack)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Slack MCP or Slack Web API
- **Workspace**: `[your-workspace]`
- **How skills use it**: Standup posts to team channel, digest summarizes threads

ACTIVEEOF
      ;;
    discord)
      cat >> "$ACTIVE_FILE" << 'ACTIVEEOF'
- **API**: Discord API or Discord MCP
- **Server**: `[your-server]`
- **How skills use it**: Standup posts to team channel

ACTIVEEOF
      ;;
  esac
fi

print_step "Generated ${ACTIVE_FILE##*/}"

# ─── Tool-specific setup ─────────────────────────────────────────────────────
print_header "Installing skills for ${AI_LABEL}"

SKILLS_DIR="${REPO_DIR}/skills"
INSTALLED=0

case "$AI_TOOL" in
  claude-code)
    TARGET_DIR="${HOME}/.claude/commands"
    mkdir -p "$TARGET_DIR"
    for skill_dir in "$SKILLS_DIR"/*/; do
      skill_name="$(basename "$skill_dir")"
      skill_file="${skill_dir}SKILL.md"
      if [[ -f "$skill_file" ]]; then
        ln -sf "$skill_file" "${TARGET_DIR}/${skill_name}.md"
        INSTALLED=$((INSTALLED + 1))
      fi
    done
    if [[ $INSTALLED -gt 0 ]]; then
      print_step "Symlinked ${INSTALLED} skills to ~/.claude/commands/"
    else
      print_warn "No SKILL.md files found yet — skills will be linked as they're created"
    fi
    ;;

  cursor)
    TARGET_DIR="${REPO_DIR}/.cursor/rules"
    mkdir -p "$TARGET_DIR"
    for skill_dir in "$SKILLS_DIR"/*/; do
      skill_name="$(basename "$skill_dir")"
      skill_file="${skill_dir}SKILL.md"
      if [[ -f "$skill_file" ]]; then
        cp "$skill_file" "${TARGET_DIR}/${skill_name}.mdc"
        INSTALLED=$((INSTALLED + 1))
      fi
    done
    if [[ $INSTALLED -gt 0 ]]; then
      print_step "Copied ${INSTALLED} skills to .cursor/rules/"
    else
      print_warn "No SKILL.md files found yet — rules will be created as skills are added"
    fi
    ;;

  codex)
    AGENTS_FILE="${REPO_DIR}/AGENTS.md"
    if [[ -f "$AGENTS_FILE" ]]; then
      print_step "AGENTS.md already exists — skills are referenced there"
    else
      print_warn "AGENTS.md not found"
    fi
    ;;

  other)
    print_step "Skills are in skills/*/SKILL.md — copy into your tool's system prompt"
    ;;
esac

# ─── Summary ──────────────────────────────────────────────────────────────────
print_header "Setup complete"
echo ""
echo -e "  ${BOLD}AI Tool:${RESET}   ${AI_LABEL}"
echo -e "  ${BOLD}Notes:${RESET}     ${NOTES_LABEL}"
echo -e "  ${BOLD}Tasks:${RESET}     ${TASKS_LABEL}"
echo -e "  ${BOLD}Calendar:${RESET}  ${CALENDAR_LABEL}"
echo -e "  ${BOLD}Chat:${RESET}      ${CHAT_LABEL}"
echo -e "  ${BOLD}Auth:${RESET}      ${AUTH_LABEL}"
echo ""
echo -e "  ${DIM}Config written to: integrations/active.md${RESET}"
echo ""

# ─── Next steps ───────────────────────────────────────────────────────────────
print_header "Next steps"
echo ""
echo -e "  1. Edit ${CYAN}shared/context/about-me.md${RESET} — tell the AI who you are"
echo -e "  2. Add voice samples to ${CYAN}shared/context/writing.md${RESET}"
echo -e "  3. Fill in the ${CYAN}[placeholders]${RESET} in integrations/active.md"

STEP=4
if [[ "$NOTES" == "notion" ]]; then
  echo -e "  ${STEP}. Add your Notion database IDs to integrations/active.md"
  STEP=$((STEP + 1))
fi

if [[ "$AUTH" == "zapier-sdk" ]]; then
  echo -e "  ${STEP}. Set up the Zapier MCP server: ${CYAN}https://github.com/zapier/zapier-mcp${RESET}"
  STEP=$((STEP + 1))
fi

echo ""
echo -e "  Then try your first skill:"
case "$AI_TOOL" in
  claude-code)
    echo -e "  ${BOLD}> /morning-kickoff${RESET}"
    ;;
  cursor)
    echo -e "  ${BOLD}Type \"good morning\" in Cursor chat${RESET}"
    ;;
  codex)
    echo -e "  ${BOLD}> morning-kickoff${RESET}"
    ;;
  *)
    echo -e "  ${BOLD}Copy skills/morning-kickoff/SKILL.md into your tool${RESET}"
    ;;
esac
echo ""
echo -e "  ${DIM}Run ./setup.sh again anytime to change your configuration.${RESET}"
echo ""
