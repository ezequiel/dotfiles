return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  opts = {
    auto_install = true,
    ignore_install = { "norg" },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    -- rainbow = {
    --   enable = true,
    --   extended_mode = true,
    --   max_file_lines = nil,
    -- },
    indent = { enable = true },
    autotag = {
      enable = true,
    },
    matchup = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
