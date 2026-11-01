vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/mikavilpas/yazi.nvim',
})

require('yazi').setup({
  open_for_directories = false,
  yazi_floating_window_border = 'none',
  floating_window_scaling_factor = 1,
  keymaps = {
    change_working_directory = false,
    copy_relative_path_to_selected_files = false,
    cycle_open_buffers = false,
    grep_in_directory = '<c-s>',
    open_and_pick_window = false,
    open_file_in_horizontal_split = '<c-h>',
    open_file_in_tab = false,
    open_file_in_vertical_split = '<c-v>',
    replace_in_directory = '<c-r>',
    send_to_quickfix_list = '<c-q>',
    show_help = '?',
  },
  integrations = {
    -- ponytail: selection-scope grep has no fff UI; widens to the file's directory
    grep_in_directory = function(dir) require('fff').live_grep({ cwd = dir }) end,
    grep_in_selected_files = function(selected_files, _)
      require('fff').live_grep({ cwd = vim.fn.fnamemodify(tostring(selected_files[1]), ':h') })
    end,
  },
})

vim.keymap.set('n', '<leader>yy', '<cmd>Yazi<CR>')
vim.keymap.set('n', '<leader>yt', '<cmd>Yazi toggle<CR>')
vim.keymap.set('n', '<leader>bd', function()
  require('yazi.utils').bufdelete('bundled-snacks', vim.api.nvim_get_current_buf())
end)
