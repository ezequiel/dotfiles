return {
  'MeanderingProgrammer/treesitter-modules.nvim',
  dependencies = {
    {
      'nvim-treesitter/nvim-treesitter',
      branch = 'main',
      build = ':TSUpdate',
    },
  },
  opts = {
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
    textobjects = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-s>',
        node_incremental = '<c-n>',
        scope_incremental = '<c-s>',
        node_decremental = '<c-d>',
      },
    },
  },
}
