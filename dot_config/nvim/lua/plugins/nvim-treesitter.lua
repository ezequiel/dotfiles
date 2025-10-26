return {
  lazy = false,
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    textobjects = { enable = true },
  },
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
