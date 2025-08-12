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
        accept_word = false,
        accept_line = false,
        next = false,
        prev = false,
        dismiss = '<C-c>',
      },
    },
    panel = { enabled = false },
    server = {
      type = 'nodejs',
      custom_server_filepath = vim.env.XDG_DATA_HOME
        .. '/mise/installs/npm-github-copilot-language-server/latest/bin/copilot-language-server',
    },
    copilot_model = 'gpt-5',
  },
}
