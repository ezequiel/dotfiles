return {
  'luckasRanarison/tailwind-tools.nvim',
  name = 'tailwind-tools',
  build = ':UpdateRemotePlugins',
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    document_color = {
      enabled = false,
    },
  },
}
