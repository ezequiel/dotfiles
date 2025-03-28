return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = false,
      fmt = string.lower,
      section_separators = { left = "", right = "" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_c = {
        "diff",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        "searchcount",
      },
      lualine_b = {},
      lualine_x = {},
      lualine_y = {
        "branch",
      },
      lualine_z = { "lsp_status" },
    },
  },
}
