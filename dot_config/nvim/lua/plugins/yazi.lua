return {
  "mikavilpas/yazi.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>yy",
      "<cmd>Yazi<cr>",
      mode = { "n", "x" },
      desc = "Open yazi at the current file",
    },
    {
      "<leader>yt",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
    {
      "<leader>yr",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    open_for_directories = true,
    yazi_floating_window_border = "single",
    keymaps = {
      show_help = "?",
      open_file_in_vertical_split = "<c-v>",
      open_file_in_horizontal_split = "<c-h>",
      send_to_quickfix_list = "<c-q>",
      open_file_in_tab = false,
      grep_in_directory = "<c-s>",
      replace_in_directory = "<c-r>",
      cycle_open_buffers = false,
      copy_relative_path_to_selected_files = false,
      change_working_directory = false,
    },
    integrations = {
      grep_in_directory = "snacks.picker",
      grep_in_selected_files = "snacks.picker",
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
