#!/usr/bin/env bash
# Report compact git working-tree status as $git workspace token.
herdr="${HERDR_BIN_PATH:-herdr}"

workspaces=$("$herdr" workspace list 2>/dev/null) || exit 0
panes=$("$herdr" pane list 2>/dev/null) || exit 0

python3 -c "
import sys, json, os, subprocess

herdr = os.environ.get('HERDR_BIN_PATH', 'herdr')
workspaces = json.loads(sys.argv[1]).get('result', {}).get('workspaces', [])
panes = json.loads(sys.argv[2]).get('result', {}).get('panes', [])

# build map: workspace_id -> first pane cwd
pane_cwd = {}
for p in panes:
    ws = p.get('workspace_id', '')
    if ws not in pane_cwd:
        cwd = p.get('foreground_cwd') or p.get('cwd') or ''
        if cwd:
            pane_cwd[ws] = cwd

for ws in workspaces:
    ws_id = ws.get('workspace_id', '')
    cwd = pane_cwd.get(ws_id, '')
    if not cwd:
        continue

    try:
        out = subprocess.check_output(
            ['git', '-C', cwd, 'status', '--porcelain=v1'],
            stderr=subprocess.DEVNULL, text=True, timeout=3
        )
    except Exception:
        continue

    if not out.strip():
        token = ''
    else:
        staged = modified = untracked = conflicts = 0
        for line in out.splitlines():
            if len(line) < 2:
                continue
            x, y = line[0], line[1]
            if x == '?' and y == '?':
                untracked += 1
            elif x in ('U', 'A', 'D', 'M') and y in ('U', 'A', 'D', 'M'):
                conflicts += 1
            else:
                if x != ' ' and x != '?':
                    staged += 1
                if y != ' ' and y != '?':
                    modified += 1
        parts = []
        if conflicts: parts.append(f'!{conflicts}')
        if staged:    parts.append(f'+{staged}')
        if modified:  parts.append(f'~{modified}')
        if untracked: parts.append(f'?{untracked}')
        token = ' '.join(parts)

    if not token:
        key, val = 'git_clean', '✓'
    elif conflicts:
        key, val = 'git_conflict', token
    else:
        key, val = 'git_dirty', token

    subprocess.Popen([
        herdr, 'workspace', 'report-metadata', ws_id,
        '--source', 'herdr-opencode',
        '--token', f'git_clean=',
        '--token', f'git_dirty=',
        '--token', f'git_conflict=',
        '--token', f'{key}={val}',
        '--ttl-ms', '30000',
    ])
" "$workspaces" "$panes" 2>/dev/null
