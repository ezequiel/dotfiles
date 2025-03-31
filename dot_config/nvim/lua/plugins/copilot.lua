return {
  "zbirenbaum/copilot.lua",
  event = "VeryLazy",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = "<tab>",
        accept_word = false,
        accept_line = false,
        next = "<C-n>",
        prev = "<C-p>",
        dismiss = "<C-d>",
      },
    },
    panel = { enabled = false },
  },
}
