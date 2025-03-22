return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
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
    ensure_installed = {
      "angular",
      "bash",
      "dockerfile",
      "git_config",
      "gitcommit",
      "gitignore",
      "go",
      "gomod",
      "groovy",
      "ini",
      "javascript",
      "json",
      "jsonc",
      "lua",
      "markdown",
      "markdown_inline",
      "regex",
      "scss",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "yaml",
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
