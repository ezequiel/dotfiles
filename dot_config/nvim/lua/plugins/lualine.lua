local is_hidden = true
return {
  "nvim-lualine/lualine.nvim",
  keys = {
    {
      "<leader>ll",
      function()
        if is_hidden then
          require("lualine").hide({ unhide = true })
          vim.opt.laststatus = 3
          is_hidden = false
        else
          vim.opt.laststatus = 0
          require("lualine").hide()
          is_hidden = true
        end
      end,
    },
  },
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = false,
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
  config = function(_, opts)
    local lualine = require("lualine")
    lualine.setup(opts)
    lualine.hide()
    vim.opt.laststatus = 0
  end,
}
