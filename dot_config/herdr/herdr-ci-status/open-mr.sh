#!/usr/bin/env bash
# Action: open the "My MRs" pane. Resolves the focused workspace's repo dir (if any) and
# passes it as CLI auth/host context; the pane lists MRs across all repos, so a missing
# repo is non-fatal (the pane falls back to the default glab/gh host).
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

# Like open.sh: do NOT pass --cwd (herdr resolves "bash mr-pane.sh" against the plugin root);
# pass the repo via --env instead so the pane can use it for glab/gh host context.
args=(plugin pane open --plugin gitlab-ci-status --entrypoint mr --placement split --direction right --focus)
if [ -n "$repo" ] && [ -d "$repo" ]; then
  args+=(--env "GITLAB_CI_REPO=$repo")
fi
exec "$herdr_bin" "${args[@]}"
