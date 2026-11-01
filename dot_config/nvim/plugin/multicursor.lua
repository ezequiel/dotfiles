-- native multicursor keymaps (:h mcursor, nvim 0.13+)
local map = vim.keymap.set
local mc_ns = vim.api.nvim_create_namespace('nvim.multicursor')

-- movable cursors
map({ 'n', 'x' }, '<left>', '[C', { remap = true })
map({ 'n', 'x' }, '<right>', ']C', { remap = true })
map('n', '<BS>', '2Q', { remap = true }) -- count forces removal
map('n', '<c-c>', '<C-L>', { remap = true })

-- Esc clears cursors when any exist, normal Esc otherwise
map('n', '<esc>', function()
  if #vim.api.nvim_buf_get_extmarks(0, mc_ns, 0, -1, {}) > 0 then
    return '<C-L>'
  end
end, { expr = true })

-- ponytail: native has no add-at-offset; toggle-walk moves the primary along
map('n', '<D-Up>', 'Qk', { remap = true })
map('n', '<D-Down>', 'Qj', { remap = true })

map('n', '@@', 'Q', { remap = true })
map('x', 'I', 'QI', { remap = true })
map('x', 'A', 'QA', { remap = true })
map({ 'n', 'x' }, '<leader>ma', 'zq*', { remap = true })
map('x', 'M', 'zq/', { remap = true })
map('x', '<leader>M', 'zq/<C-R>"<CR>', { remap = true })
map('n', '<leader>gv', 'gQ', { remap = true })

-- search prompt, then a cursor at every match
map('n', '<leader>A', function()
  local pat = vim.fn.input('cursors at each match: ')
  if pat == '' then
    return
  end
  vim.api.nvim_feedkeys('/' .. pat, 'm', false)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('\rzqgn', true, false, true), 'm', false)
end)
