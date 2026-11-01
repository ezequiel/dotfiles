-- downloads prebuilt binary (falls back to cargo) on install/update
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'fff' and (kind == 'install' or kind == 'update') then
      if not ev.data.active then
        vim.cmd.packadd('fff')
      end
      require('fff.download').download_or_build_binary()
    end
  end,
})

vim.pack.add({
  'https://github.com/dmtrKovalenko/fff',
})

require('fff').setup({
  prompt = '→ ',
  follow_symlinks = true,
  layout = {
    prompt_position = 'top',
    preview_position = 'top',
  },
})

vim.keymap.set('n', '<leader>ff', function()
  require('fff').find_files()
end)
vim.keymap.set('n', '<leader>re', function()
  require('fff').find_files({ resume = true })
end)
vim.keymap.set('n', '<leader>rg', function()
  require('fff').live_grep()
end)
vim.keymap.set({ 'n', 'x' }, '<leader>rw', function()
  require('fff').live_grep_under_cursor()
end)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition) -- no native default; <C-]>/:tag also routes here via tagfunc
