vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})

require('conform').setup({
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

vim.api.nvim_create_autocmd('User', {
  pattern = 'AutoSaveWritePre',
  group = vim.api.nvim_create_augroup('conform-autosave', { clear = true }),
  callback = function(event)
    local bufnr = event.data.saved_buffer
    if not bufnr or not vim.bo[bufnr].modifiable then
      return
    end

    require('conform').format({
      bufnr = bufnr,
      quiet = true,
      undojoin = true,
    })
  end,
})
