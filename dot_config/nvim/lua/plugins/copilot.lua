return {
  'zbirenbaum/copilot.lua',
  event = 'VeryLazy',
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      hide_during_completion = true,
      keymap = {
        accept = false,
        accept_word = false,
        accept_line = false,
        next = '<C-n>',
        prev = '<C-p>',
        dismiss = '<C-c>',
      },
    },
    panel = { enabled = false },
    copilot_model = 'gemini-2.5-pro',
  },
}
