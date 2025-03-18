return {
  "stevearc/oil.nvim",
  opts = {
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
    git = {
      add = function()
        return true
      end,
      mv = function()
        return true
      end,
      rm = function()
        return true
      end,
    },
    keymaps = {
      ["?"] = { "actions.show_help", mode = "n" },
      ["<CR>"] = "actions.select",
      ["P"] = "actions.preview",
      ["<C-c>"] = { "actions.close", mode = "n" },
      ["R"] = "actions.refresh",
      ["<BS>"] = { "actions.parent", mode = "n" },
    },
    use_default_keymaps = false,
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>o",
      function()
        require("oil").open()
      end,
    },
  },
}
