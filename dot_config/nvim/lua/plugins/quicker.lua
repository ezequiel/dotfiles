return {
  'stevearc/quicker.nvim',
  ft = 'qf',
  opts = {
    opts = {
      signcolumn = 'no',
    },
    edit = {
      enabled = false,
    },
    wrap = false,
    borders = {
      vert = '|',
      strong_header = '-',
      strong_cross = '-',
      strong_end = '|',
      soft_header = '╌',
      soft_cross = '|',
      soft_end = '|',
    },
    trim_leading_whitespace = false,
    max_filename_width = function()
      return 48
    end,
    keys = {
      {
        'r',
        function()
          require('quicker').refresh()
        end,
        desc = 'Refresh quickfix',
      },
      {
        '>',
        function()
          require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
        end,
        desc = 'Expand quickfix context',
      },
      {
        '<',
        function()
          require('quicker').collapse()
        end,
        desc = 'Collapse quickfix context',
      },
    },
  },
  keys = {
    {
      '<leader>qf',
      function()
        require('quicker').toggle({ focus = true, open_cmd_mods = { split = 'botright' } })
      end,
      desc = 'Toggle Quickfix',
    },
  },
}
