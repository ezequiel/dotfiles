return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "VeryLazy",
  opts = {
    auto_install = true,
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
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "vimdoc",
      "lua",
      "markdown",
      "markdown_inline",
      "json",
      "jsonc",
      "regex",
      "bash",
      "go",
      "gomod",
      "vim",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
