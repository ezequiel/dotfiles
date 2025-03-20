return {
  "stevearc/oil.nvim",
  lazy = false,
  opts = {
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
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
    skip_confirm_for_simple_edits = false,
    constrain_cursor = "name",
    lsp_file_methods = {
      enabled = true,
      timeout_ms = 9999,
      autosave_changes = true,
    },
    preview_split = "right",
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>o",
      function()
        require("oil").toggle_float()
      end,
    },
  },
}
