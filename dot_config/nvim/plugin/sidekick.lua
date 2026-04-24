vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

require('sidekick').setup({
  nes = {
    enabled = false,
  },
  cli = {
    picker = 'fzf-lua',
    win = {
      keys = {
        buffers = { '<leader>fb', 'buffers', mode = 'nt' },
        files = { '<leader>ff', 'files', mode = 'nt' },
        prompt = { '<leader>os', 'prompt', mode = 'nt' },
        hide_n = { '<c-c>', 'hide', mode = 'nt' },
        hide_ctrl_q = { '<c-c>', 'hide', mode = 'nt' },
        hide_ctrl_dot = { '<c-c>', 'hide', mode = 'nt' },
        hide_ctrl_z = { '<c-c>', 'hide', mode = 'nt' },
      },
    },
    mux = {
      backend = 'tmux',
      enabled = true,
    },
  },
})

vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  require('sidekick.cli').toggle({ name = 'opencode', focus = true })
end)

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
  require('sidekick.cli').send({ name = 'opencode', focus = true, msg = '{this}' })
end)

vim.keymap.set('n', '<leader>oA', function()
  require('sidekick.cli').send({ name = 'opencode', focus = true, msg = '{file}' })
end)

vim.keymap.set({ 'n', 'x', 't' }, '<leader>os', require('sidekick.cli').prompt)
