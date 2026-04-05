vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
  format_after_save = {
    async = true,
    quiet = true,
    undojoin = true,
  },
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
    sh = { 'shfmt' },
    bash = { 'shfmt' },
    zsh = { 'shfmt' },
  },
  notify_on_error = false,
  log_level = vim.log.levels.OFF,
})
