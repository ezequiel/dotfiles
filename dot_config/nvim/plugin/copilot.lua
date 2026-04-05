vim.pack.add({
  'https://github.com/zbirenbaum/copilot.lua',
}, { load = function() end })

vim.api.nvim_create_autocmd('InsertEnter', {
  group = 'my-config',
  once = true,
  callback = function()
    vim.cmd.packadd('copilot.lua')

    require('copilot').setup({
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = 'off',
          },
          advanced = {
            listCount = 1,
            inlineSuggestCount = 1,
          },
        },
      },
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<tab>',
          dismiss = false,
          next = false,
          prev = false,
        },
      },
      panel = { enabled = false },
      nes = { enabled = false },
      server = {
        type = 'nodejs',
        custom_server_filepath = vim.fn.exepath('copilot-language-server'),
      },
    })
  end,
})
