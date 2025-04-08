return {
  'sindrets/diffview.nvim',
  cmd = 'DiffviewOpen',
  config = function()
    local actions = require('diffview.actions')
    require('diffview').setup({
      file_panel = {
        win_config = {
          win_opts = { signcolumn = 'no' },
        },
      },
      keymaps = {
        disable_defaults = true,
        file_panel = {
          {
            'n',
            'j',
            actions.next_entry,
            { desc = 'Bring the cursor to the next file entry' },
          },
          {
            'n',
            '<down>',
            actions.next_entry,
            { desc = 'Bring the cursor to the next file entry' },
          },
          {
            'n',
            'k',
            actions.prev_entry,
            { desc = 'Bring the cursor to the previous file entry' },
          },
          {
            'n',
            '<up>',
            actions.prev_entry,
            { desc = 'Bring the cursor to the previous file entry' },
          },
          {
            'n',
            '<cr>',
            actions.select_entry,
            { desc = 'Open the diff for the selected entry' },
          },
          { 'n', 'zR', actions.open_all_folds, { desc = 'Expand all folds' } },
          { 'n', 'zM', actions.close_all_folds, { desc = 'Collapse all folds' } },
          { 'n', 'za', actions.toggle_fold, { desc = 'Toggle fold' } },
          { 'n', '?', actions.help('file_panel'), { desc = 'Open the help panel' } },
        },
      },
    })
  end,
}
