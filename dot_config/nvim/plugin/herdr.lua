local herdr  = vim.env.HERDR_BIN_PATH or 'herdr'
local socket = vim.env.HERDR_SOCKET_PATH or (vim.env.HOME .. '/.config/herdr/herdr.sock')

-- herdr-splits.nvim: seamless ctrl+shift+arrow nav across nvim splits and herdr panes
vim.pack.add({ 'https://github.com/lmilojevicc/herdr-splits.nvim' })
if vim.env.HERDR_ENV == '1' then
  require('herdr-splits').setup({
    at_edge = 'stop',
    nav_at_edge = 'stop',
    nav_keys = {
      left  = '<M-S-Left>',
      down  = '<M-S-Down>',
      up    = '<M-S-Up>',
      right = '<M-S-Right>',
    },
  })
  local hs = require('herdr-splits')
  vim.keymap.set('n', '<M-S-Left>',  hs.move_cursor_left,  { desc = 'Navigate left' })
  vim.keymap.set('n', '<M-S-Down>',  hs.move_cursor_down,  { desc = 'Navigate down' })
  vim.keymap.set('n', '<M-S-Up>',    hs.move_cursor_up,    { desc = 'Navigate up' })
  vim.keymap.set('n', '<M-S-Right>', hs.move_cursor_right, { desc = 'Navigate right' })
end

local function pane_focus(pane_id, tab_id, workspace_id)
  if workspace_id then vim.system({ herdr, 'workspace', 'focus', workspace_id }) end
  if tab_id       then vim.system({ herdr, 'tab',       'focus', tab_id       }) end
  local p = '{"id":"pf","method":"pane.focus","params":{"pane_id":"' .. pane_id .. '"}}\n'
  vim.system({ 'sh', '-c', 'printf "%s" ' .. vim.fn.shellescape(p) .. ' | nc -U ' .. vim.fn.shellescape(socket) })
end

local function oc_agents()
  local r = vim.system({ herdr, 'agent', 'list' }, { text = true }):wait()
  if r.code ~= 0 then return {} end
  local ok, d = pcall(vim.json.decode, r.stdout)
  if not ok then return {} end
  return vim.tbl_filter(function(a)
    return (a.agent or ''):lower():find('opencode') ~= nil
  end, (d.result or {}).agents or {})
end

local function current_tab_id()
  -- get live tab id from socket (env var may be stale if pane was moved)
  local p = '{"id":"cur-tab","method":"pane.current","params":{"caller_pane_id":"' .. (vim.env.HERDR_PANE_ID or '') .. '"}}\n'
  local r = vim.system(
    { 'sh', '-c', 'printf "%s" ' .. vim.fn.shellescape(p) .. ' | nc -U ' .. vim.fn.shellescape(socket) },
    { text = true }
  ):wait()
  if r.code ~= 0 then return vim.env.HERDR_TAB_ID end
  local ok, d = pcall(vim.json.decode, r.stdout)
  if not ok then return vim.env.HERDR_TAB_ID end
  return ((d.result or {}).pane or {}).tab_id or vim.env.HERDR_TAB_ID
end

local function oc_start_new()
  local tab_id = current_tab_id()
  if not tab_id or tab_id == '' then
    vim.notify('could not determine current tab', vim.log.levels.ERROR)
    return
  end
  -- unique name to avoid agent_name_taken error
  local name = 'opencode-' .. os.time()
  vim.system({
    herdr, 'agent', 'start', name,
    '--tab', tab_id,
    '--split', 'right',
    '--focus',
    '--cwd', vim.fn.getcwd(),
    '--', 'opencode',
  })
end

-- <leader>ot — focus opencode in THIS tab, or start one here if none
vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  local nvim_tab = current_tab_id()
  local oc = oc_agents()
  -- prefer agents in the same tab
  local tab_oc = vim.tbl_filter(function(a)
    return a.tab_id == nvim_tab
  end, oc)
  local candidates = #tab_oc > 0 and tab_oc or {}
  if #candidates == 0 then
    oc_start_new()
  else
    local a = candidates[#candidates]
    pane_focus(a.pane_id, a.tab_id, a.workspace_id)
  end
end, { desc = 'Focus opencode in current tab' })

-- <leader>on — always start a new opencode pane
vim.keymap.set({ 'n', 't' }, '<leader>on', function()
  oc_start_new()
end, { desc = 'Start new opencode pane' })

-- send context to opencode via herdr agent send
local function send_to_opencode(text)
  local nvim_tab = current_tab_id()
  local oc = oc_agents()
  -- prefer agent in same tab
  local target = nil
  for _, a in ipairs(oc) do
    if a.tab_id == nvim_tab then target = a; break end
  end
  if not target then
    -- none in this tab — start one, then send once it's ready
    oc_start_new()
    vim.notify('started opencode — resend after it loads', vim.log.levels.INFO)
    return
  end
  vim.system({ herdr, 'agent', 'send', target.pane_id, text })
  pane_focus(target.pane_id, target.tab_id, target.workspace_id)
end

-- <leader>oa n: @file#line
vim.keymap.set('n', '<leader>oa', function()
  send_to_opencode('@' .. vim.fn.expand('%:p') .. '#' .. vim.fn.line('.') .. ' ')
end, { desc = 'Send @file#line to opencode' })

-- <leader>oa x: @file#start-end
vim.keymap.set('x', '<leader>oa', function()
  local s = vim.fn.line('v')
  local e = vim.fn.line('.')
  if s > e then s, e = e, s end
  send_to_opencode('@' .. vim.fn.expand('%:p') .. '#' .. s .. '-' .. e .. ' ')
end, { desc = 'Send @file#start-end to opencode' })

-- <leader>oA: @file only
vim.keymap.set('n', '<leader>oA', function()
  send_to_opencode('@' .. vim.fn.expand('%:p') .. ' ')
end, { desc = 'Send @file to opencode' })


