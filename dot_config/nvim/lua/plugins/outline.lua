return {
  'hedyhli/outline.nvim',
  keys = {
    {
      '<leader>ol',
      function()
        local outline = require('outline')
        outline.toggle_outline()
        vim.defer_fn(function()
          outline.focus_outline()
        end, 500)
      end,
      desc = 'Toggle outline',
    },
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
      goto_location = { 'gd' },
      peek_location = { '<CR>' },
      goto_and_close = {},
      restore_location = {},
      hover_symbol = { 'K' },
      toggle_preview = {},
      rename_symbol = { '<leader>rn' },
      code_actions = { '<leader>ca' },
      fold = { '<Left>', '<Backspace>' },
      unfold = { '<Right>' },
      fold_toggle = { '<Space>', 'za' },
      fold_toggle_all = {},
      fold_all = { 'zM' },
      unfold_all = { 'zR' },
      fold_reset = {},
      down_and_jump = {},
      up_and_jump = {},
    },
  },
}
