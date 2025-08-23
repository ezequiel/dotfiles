return {
  'stevearc/conform.nvim',
  event = { { event = 'User', pattern = 'AutoSaveWritePost' } },
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
    notify_no_formatters = false,
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    conform.format({ async = true, bufnr = vim.api.nvim_get_current_buf() })
    vim.api.nvim_create_autocmd('User', {
      pattern = 'AutoSaveWritePost',
      callback = function(event)
        conform.format({ async = true, bufnr = event.data.saved_buffer })
      end,
    })
  end,
}
