return {
  'stevearc/conform.nvim',
  lazy = false,
  opts = {
    formatters_by_ft = {
      ['*'] = { 'trim_newlines', 'trim_whitespace' },
      css = { 'prettier' },
      dockerfile = { 'dockerfmt' },
      go = { 'goimports' },
      html = { 'prettier' },
      htmlangular = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      lua = { 'stylua' },
      markdown = { 'prettier' },
      scss = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      yaml = { 'yamlfmt' },
      toml = { 'taplo' },
      sh = { 'shellcheck', 'shfmt' },
      bash = { 'shellcheck', 'shfmt' },
      zsh = { 'shellcheck', 'shfmt' },
    },
    notify_on_error = false,
    log_level = vim.log.levels.OFF,
    default_format_opts = {
      quiet = true,
      async = true,
    },
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    vim.api.nvim_create_autocmd('User', {
      pattern = 'AutoSaveWritePost',
      callback = function(event)
        conform.format({ bufnr = event.data.saved_buffer })
      end,
    })
  end,
}
