#!/usr/bin/env bash
# Strip "OC | " from opencode terminal titles and report as $title token.
herdr="${HERDR_BIN_PATH:-herdr}"

scan_all() {
  local agents
  agents=$("$herdr" agent list 2>/dev/null) || return
  python3 -c "
import sys, json, os, subprocess, re

herdr = os.environ.get('HERDR_BIN_PATH', 'herdr')
data = json.loads(sys.argv[1])
agents = data.get('result', {}).get('agents', [])

for a in agents:
    if 'opencode' not in (a.get('agent') or '').lower():
        continue
    pane_id = a.get('pane_id', '')
    title = re.sub(r'^OC \| ', '', a.get('terminal_title_stripped') or '')
    subprocess.Popen([
        herdr, 'pane', 'report-metadata', pane_id,
        '--source', 'herdr-opencode',
        '--token', f'title={title}',
    ])
" "$agents"
}

# Run immediately
scan_all

# Re-run after a short delay to catch titles set asynchronously (e.g. session resume)
(sleep 2 && scan_all) &
