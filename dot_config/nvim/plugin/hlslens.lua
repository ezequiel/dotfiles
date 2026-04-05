vim.pack.add({
  'https://github.com/rapan931/lasterisk.nvim',
  'https://github.com/kevinhwang91/nvim-hlslens',
})

require('hlslens').setup({
  calm_down = true,
  nearest_only = true,
  virt_priority = 1,
  override_lens = function(render, posList, nearest, idx, _)
    local lnum, col = unpack(posList[idx])
    local cnt = #posList
    local text = ('[%d/%d]'):format(idx, cnt)
    local chunks
    if nearest then
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
    else
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  end,
})

vim.keymap.set('n', 'n', function()
  local count = vim.v.count1
  local key = (count > 1 and count or '') .. 'n'
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
  require('hlslens').start()
end)
vim.keymap.set('n', 'N', function()
  local count = vim.v.count1
  local key = (count > 1 and count or '') .. 'N'
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
  require('hlslens').start()
end)
vim.keymap.set('n', '*', function()
  require('lasterisk').search({ is_whole = true })
  require('hlslens').start()
end)
vim.keymap.set('x', '*', function()
  require('lasterisk').search({ is_whole = false })
  require('hlslens').start()
end)
