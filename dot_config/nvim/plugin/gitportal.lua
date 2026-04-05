vim.pack.add({ 'https://codeberg.org/trevorhauter/gitportal.nvim' })

require('gitportal').setup({ always_include_current_line = true })

vim.keymap.set({ 'n', 'x' }, '<leader>gy', require('gitportal').copy_link_to_clipboard)
vim.keymap.set({ 'n', 'x' }, '<leader>gh', require('gitportal').open_file_in_browser)

vim.keymap.set('n', 'gH', require('gitportal').open_file_in_neovim)
