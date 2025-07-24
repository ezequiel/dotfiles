return {
  'zeioth/garbage-day.nvim',
  dependencies = 'neovim/nvim-lspconfig',
  lazy = false,
  opts = {
    -- aggressive_mode = true,
    excluded_lsp_clients = { 'copilot' },
  },
}
