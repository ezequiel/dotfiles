return {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = false,
        accept_word = false,
        accept_line = false,
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-c>",
      },
    },
    panel = { enabled = false },
    -- init = function()
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "BlinkCmpMenuOpen",
    --     callback = function()
    --       require("copilot.suggestion").dismiss()
    --       vim.b.copilot_suggestion_hidden = true
    --     end,
    --   })
    --   vim.api.nvim_create_autocmd("User", {
    --     pattern = "BlinkCmpMenuClose",
    --     callback = function()
    --       vim.b.copilot_suggestion_hidden = false
    --     end,
    --   })
    -- end,
  },
}
