vim.pack.add({
  'https://github.com/assistcontrol/readline.nvim',
})

vim.keymap.set({ '!', 'n' }, '<M-b>', require('readline').backward_word)
vim.keymap.set({ '!', 'n' }, '<M-f>', require('readline').forward_word)
vim.keymap.set({ '!', 'n', 'x' }, '<C-a>', require('readline').dwim_beginning_of_line)
vim.keymap.set({ '!', 'n', 'x' }, '<C-e>', require('readline').end_of_line)
vim.keymap.set({ 'n', 'x' }, '0', require('readline').dwim_beginning_of_line)
vim.keymap.set('!', '<M-BS>', require('readline').backward_kill_word)
vim.keymap.set('!', '<C-k>', require('readline').kill_line)
