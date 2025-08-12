return {
  ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  opts = {
    settings = {
      publish_diagnostic_on = 'change',
      expose_as_code_action = { 'fix_all', 'add_missing_imports', 'remove_unused_imports' },
      -- tsserver_path = vim.env.XDG_DATA_HOME
      --   .. '/mise/installs/npm-typescript-language-server/latest/bin/typescript-language-server',
      jsx_close_tag = {
        enable = true,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
      tsserver_format_options = {},
      tsserver_file_preferences = {
        -- importModuleSpecifierPreference = 'non-relative',
      },
    },
  },
}
