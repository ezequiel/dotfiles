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
    skip_confirm_for_simple_edits = true,
    constrain_cursor = "name",
    lsp_file_methods = {
      autosave_changes = true,
    },
    preview_split = "right",
  },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    {
      "<leader>o",
      function()
        local oil = require("oil")
        oil.toggle_float()
        vim.api.nvim_create_autocmd("User", {
          pattern = "OilEnter",
          callback = vim.schedule_wrap(function(args)
            if vim.api.nvim_get_current_buf() == args.data.buf and oil.get_cursor_entry() then
              oil.open_preview()
            end
          end),
        })
      end,
    },
  },
}
