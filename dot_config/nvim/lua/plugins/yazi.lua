return {
  "mikavilpas/yazi.nvim",
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>yy",
      "<cmd>Yazi<cr>",
      mode = { "n", "v" },
      desc = "Open yazi at the current file",
    },
    {
      "<leader>yt",
      "<cmd>Yazi toggle<cr>",
      desc = "Resume the last yazi session",
    },
  },
  opts = {
    open_for_directories = true,
    yazi_floating_window_border = "single",
    keymaps = {
      show_help = "?",
      open_file_in_vertical_split = "|",
      open_file_in_horizontal_split = "-",
      send_to_quickfix_list = "<c-q>",
      open_file_in_tab = false,
      grep_in_directory = false,
      replace_in_directory = false,
      cycle_open_buffers = false,
      copy_relative_path_to_selected_files = false,
      change_working_directory = false,
    },
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end,
}
