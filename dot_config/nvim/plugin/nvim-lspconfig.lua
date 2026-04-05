vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

vim.lsp.enable({
  'bashls',
  'cucumber_language_server',
  'dockerls',
  'eslint',
  'golangci_lint_ls',
  'gopls',
  'html',
  'jsonls',
  'lua_ls',
  'marksman',
  'vtsls',
  'yamlls',
})

-- Angular LSP is extremely slow and lags everything
vim.keymap.set('n', '<leader>ng', function()
  vim.lsp.enable('angularls')
end)

vim.keymap.set('n', '<leader>tw', function()
  vim.lsp.enable('tailwindcss')
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = 'my-config',
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client or (client.name ~= 'vtsls' and client.name ~= 'angularls') then
      return
    end

    if client.name == 'vtsls' then
      local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'angularls' })
      if #angularLsClients > 0 then
        client.server_capabilities.referencesProvider = false
        client.server_capabilities.renameProvider = false
      end
    elseif client.name == 'angularls' then
      local vtslsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'vtsls' })
      if #vtslsClients > 0 then
        vtslsClients[1].server_capabilities.referencesProvider = false
        vtslsClients[1].server_capabilities.renameProvider = false
      end
    end
  end,
})
