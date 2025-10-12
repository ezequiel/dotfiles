return {
  'mikavilpas/yazi.nvim',
  dependencies = { 'folke/snacks.nvim' },
  keys = {
    {
      '<leader>yy',
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>yt',
      '<cmd>Yazi toggle<cr>',
      desc = 'Resume the last yazi session',
    },
  },
  opts = {
    open_for_directories = false,
    yazi_floating_window_border = 'none',
    floating_window_scaling_factor = 1,
    keymaps = {
      change_working_directory = false,
      copy_relative_path_to_selected_files = nil,
      cycle_open_buffers = false,
      grep_in_directory = '<c-s>',
      open_and_pick_window = '<c-o>',
      open_file_in_horizontal_split = '<c-h>',
      open_file_in_tab = false,
      open_file_in_vertical_split = '<c-v>',
      replace_in_directory = '<c-r>',
      send_to_quickfix_list = '<c-q>',
      show_help = '?',
    },
    integrations = {
      grep_in_directory = 'snacks.picker',
      grep_in_selected_files = 'snacks.picker',
      picker_add_copy_relative_path_action = 'snacks.picker',
    },
  },
}
