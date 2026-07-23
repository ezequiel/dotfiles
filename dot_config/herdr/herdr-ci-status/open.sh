#!/usr/bin/env bash
# Action: resolve the current workspace's repo dir, then open the live CI pane there.
set -euo pipefail
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib.sh
. "$DIR/lib.sh"

herdr_bin="${HERDR_BIN_PATH:-herdr}"
ctx="${HERDR_PLUGIN_CONTEXT_JSON:-}"

repo=""
if [ -n "$ctx" ] && command -v jq >/dev/null 2>&1; then
  repo="$(printf '%s' "$ctx" | jq -r '.focused_pane_cwd // .workspace_cwd // empty' 2>/dev/null || true)"
fi
[ -n "$repo" ] || repo="${HERDR_WORKSPACE_CWD:-}"

if [ -z "$repo" ] || [ ! -d "$repo" ]; then
  printf 'gitlab-ci-status: could not resolve a repo directory from the workspace context.\n' >&2
  exit 1
fi

# NOTE: do NOT pass --cwd "$repo". herdr resolves the relative pane command
# ("bash ci-pane.sh") against the process cwd; --cwd would move it off the plugin
# root and bash would fail to find ci-pane.sh (the pane opens then closes instantly).
# The repo is passed via --env instead, and ci-pane.sh uses `git -C "$REPO"`.
exec "$herdr_bin" plugin pane open \
  --plugin gitlab-ci-status \
  --entrypoint ci \
  --placement split \
  --direction right \
  --env "GITLAB_CI_REPO=$repo" \
  --focus
