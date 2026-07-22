local herdr  = vim.env.HERDR_BIN_PATH or 'herdr'
local socket = vim.env.HERDR_SOCKET_PATH or (vim.env.HOME .. '/.config/herdr/herdr.sock')

-- herdr-splits.nvim: alt+shift+arrows nav across nvim splits and herdr panes
vim.pack.add({ 'https://github.com/lmilojevicc/herdr-splits.nvim' })
if vim.env.HERDR_ENV == '1' then
  require('herdr-splits').setup({
    at_edge = 'stop',
    nav_at_edge = 'stop',
    nav_keys = { left='<M-S-Left>', down='<M-S-Down>', up='<M-S-Up>', right='<M-S-Right>' },
  })
  local hs = require('herdr-splits')
  vim.keymap.set('n', '<M-S-Left>',  hs.move_cursor_left,  { desc = 'Navigate left' })
  vim.keymap.set('n', '<M-S-Down>',  hs.move_cursor_down,  { desc = 'Navigate down' })
  vim.keymap.set('n', '<M-S-Up>',    hs.move_cursor_up,    { desc = 'Navigate up' })
  vim.keymap.set('n', '<M-S-Right>', hs.move_cursor_right, { desc = 'Navigate right' })
end

-- send a raw socket request, return parsed result or nil
local function sock(method, params)
  local payload = vim.json.encode({ id = 'nvim', method = method, params = params }) .. '\n'
  local r = vim.system(
    { 'sh', '-c', 'printf "%s" ' .. vim.fn.shellescape(payload) .. ' | nc -U ' .. vim.fn.shellescape(socket) },
    { text = true }
  ):wait()
  if r.code ~= 0 then return nil end
  local ok, d = pcall(vim.json.decode, r.stdout)
  return ok and d.result or nil
end

-- focus a pane by id via socket (CLI only supports directional focus)
local function pane_focus(pane_id, tab_id, workspace_id)
  if workspace_id then vim.system({ herdr, 'workspace', 'focus', workspace_id }) end
  if tab_id       then vim.system({ herdr, 'tab',       'focus', tab_id       }) end
  sock('pane.focus', { pane_id = pane_id })
end

-- live pane info from socket (env vars may be stale if pane was moved)
local function current_pane()
  local res = sock('pane.current', { caller_pane_id = vim.env.HERDR_PANE_ID or '' })
  return res and res.pane or nil
end

-- all opencode agents across the session
local function oc_agents()
  local r = vim.system({ herdr, 'agent', 'list' }, { text = true }):wait()
  if r.code ~= 0 then return {} end
  local ok, d = pcall(vim.json.decode, r.stdout)
  if not ok then return {} end
  return vim.tbl_filter(function(a)
    return (a.agent or ''):lower():find('opencode') ~= nil
  end, (d.result or {}).agents or {})
end

-- start opencode via plugin pane (runs directly, no shell flash, closes on exit)
-- returns pane_id or nil
local function oc_start_new()
  local pane = current_pane()
  if not pane then
    vim.notify('herdr: could not determine current pane', vim.log.levels.ERROR)
    return nil
  end
  local r = vim.system({
    herdr, 'plugin', 'pane', 'open',
    '--plugin', 'oc-titles',
    '--entrypoint', 'opencode',
    '--placement', 'split',
    '--direction', 'right',
    '--target-pane', pane.pane_id,
    '--cwd', vim.fn.getcwd(),
    '--focus',
  }, { text = true }):wait()
  if r.code ~= 0 then return nil end
  local ok, d = pcall(vim.json.decode, r.stdout)
  return ok and ((d.result or {}).plugin_pane or {}).pane and d.result.plugin_pane.pane.pane_id or nil
end

-- <leader>ot: focus opencode in current tab, or start one
vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  local pane  = current_pane()
  local tab   = pane and pane.tab_id or vim.env.HERDR_TAB_ID
  local oc    = oc_agents()
  local found = nil
  for _, a in ipairs(oc) do
    if a.tab_id == tab then found = a; break end
  end
  if found then
    pane_focus(found.pane_id, found.tab_id, found.workspace_id)
  else
    oc_start_new()
  end
end, { desc = 'Focus opencode in current tab' })

-- <leader>on: always start a new opencode pane
vim.keymap.set({ 'n', 't' }, '<leader>on', oc_start_new, { desc = 'Start new opencode pane' })

-- send text to opencode in current tab without submitting
-- if none running: start one, wait for ready, then send
local function send_to_opencode(text)
  local pane = current_pane()
  local tab  = pane and pane.tab_id or vim.env.HERDR_TAB_ID
  local oc   = oc_agents()
  local target = nil
  for _, a in ipairs(oc) do
    if a.tab_id == tab then target = a; break end
  end

  if target then
    vim.system({ herdr, 'pane', 'send-text', target.pane_id, text })
    pane_focus(target.pane_id, target.tab_id, target.workspace_id)
    return
  end

  -- no agent in this tab: start one, wait for UI, then send
  vim.schedule(function()
    local new_pane = oc_start_new()
    if not new_pane then return end
    vim.system({
      herdr, 'pane', 'wait-output', new_pane,
      '--source', 'visible',
      '--regex', 'esc|interrupt|commands',
      '--timeout', '30000',
    }, { text = true }, function()
      vim.defer_fn(function()
        vim.system({ herdr, 'pane', 'send-text', new_pane, text })
      end, 300)
    end)
  end)
end

-- <leader>oa n: @file#line
vim.keymap.set('n', '<leader>oa', function()
  send_to_opencode('@' .. vim.fn.expand('%:p') .. '#' .. vim.fn.line('.') .. ' ')
end, { desc = 'Send @file#line to opencode' })

-- <leader>oa x: @file#start-end
vim.keymap.set('x', '<leader>oa', function()
  local s, e = vim.fn.line('v'), vim.fn.line('.')
  if s > e then s, e = e, s end
  send_to_opencode('@' .. vim.fn.expand('%:p') .. '#' .. s .. '-' .. e .. ' ')
end, { desc = 'Send @file#start-end to opencode' })

-- <leader>oA: @file only
vim.keymap.set('n', '<leader>oA', function()
  send_to_opencode('@' .. vim.fn.expand('%:p') .. ' ')
end, { desc = 'Send @file to opencode' })
