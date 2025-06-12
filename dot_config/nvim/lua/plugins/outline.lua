return {
  'hedyhli/outline.nvim',
  keys = {
    { '<leader>ol', '<cmd>Outline<CR>', desc = 'Toggle outline' },
  },
  opts = {
    outline_window = {
      position = 'left',
      auto_close = false,
      auto_jump = false,
      focus_on_open = true,
    },
    outline_items = {
      show_symbol_details = false,
    },
    keymaps = {
      show_help = '?',
      close = { '<C-c>', 'q' },
      goto_location = { '<CR>' },
      peek_location = {},
      goto_and_close = {},
      restore_location = {},
      hover_symbol = { 'K' },
      toggle_preview = {},
      rename_symbol = {},
      code_actions = {},
      fold = { '<Left>', '<Backspace>' },
      unfold = { '<Right>' },
      fold_toggle = {},
      fold_toggle_all = {},
      fold_all = {},
      unfold_all = {},
      fold_reset = {},
      down_and_jump = {},
      up_and_jump = {},
    },
  },
}
