return {
  'echasnovski/mini.move',
  version = '*',
  keys = {
    { '<D-S-j>', "<cmd>lua MiniMove.move_line('down')<cr>", mode = { 'n' } },
    { '<D-S-k>', "<cmd>lua MiniMove.move_line('up')<cr>", mode = { 'n' } },
    { '<D-S-j>', "<cmd>lua MiniMove.move_selection('down')<cr>", mode = { 'x' } },
    { '<D-S-k>', "<cmd>lua MiniMove.move_selection('up')<cr>", mode = { 'x' } },
  },
  opts = {
    mappings = {
      left = '',
      right = '',
      down = '',
      up = '',
      line_left = '',
      line_right = '',
      line_down = '',
      line_up = '',
    },
  },
  config = function(_, opts)
    require('mini.move').setup(opts)
  end,
}
