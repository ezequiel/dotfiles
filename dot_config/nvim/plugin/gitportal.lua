vim.pack.add({ 'https://codeberg.org/trevorhauter/gitportal.nvim' })

require('gitportal').setup({ always_include_current_line = true })

-- functions renamed upstream: open_file_in_browser->to_remote, copy_link_to_clipboard->clip_remote, open_file_in_neovim->from_remote
vim.keymap.set({ 'n', 'x' }, '<leader>gy', require('gitportal').clip_remote)
vim.keymap.set({ 'n', 'x' }, '<leader>gh', require('gitportal').to_remote)

vim.keymap.set('n', 'gH', require('gitportal').from_remote)
