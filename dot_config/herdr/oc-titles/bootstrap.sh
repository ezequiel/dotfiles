#!/usr/bin/env bash
# On workspace.created: open opencode in a right split of the root pane.
herdr="${HERDR_BIN_PATH:-herdr}"

workspace_id=$(printf '%s' "${HERDR_PLUGIN_EVENT_JSON:-}" | python3 -c "
import sys, json
d = json.load(sys.stdin)
print(d.get('data', {}).get('workspace', {}).get('workspace_id', ''))
" 2>/dev/null)

[ -z "$workspace_id" ] && exit 0

pane_info=$("$herdr" pane list --workspace "$workspace_id" 2>/dev/null)

root_pane=$(printf '%s' "$pane_info" | python3 -c "
import sys, json
d = json.load(sys.stdin)
panes = d.get('result', {}).get('panes', [])
if panes:
    print(panes[0].get('pane_id', ''))
" 2>/dev/null)

[ -z "$root_pane" ] && exit 0

root_cwd=$(printf '%s' "$pane_info" | python3 -c "
import sys, json
d = json.load(sys.stdin)
panes = d.get('result', {}).get('panes', [])
if panes:
    print(panes[0].get('foreground_cwd') or panes[0].get('cwd', ''))
" 2>/dev/null)

cwd_arg=""
[ -n "$root_cwd" ] && cwd_arg="--cwd $root_cwd"

"$herdr" plugin pane open \
  --plugin oc-titles \
  --entrypoint opencode \
  --placement split \
  --direction right \
  --target-pane "$root_pane" \
  ${cwd_arg:+--cwd "$root_cwd"} \
  --no-focus
