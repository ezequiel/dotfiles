return {
  'zbirenbaum/copilot.lua',
  lazy = false,
  opts = {
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
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = false,
        accept_line = false,
        accept_word = false,
        dismiss = '<C-c>',
        next = false,
        prev = false,
      },
    },
    panel = { enabled = false },
    server = {
      type = 'nodejs',
      custom_server_filepath = vim.env.XDG_DATA_HOME
        .. '/mise/installs/npm-github-copilot-language-server/latest/bin/copilot-language-server',
    },
  },
}
