return {
  'tanvirtin/vgit.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  event = 'VeryLazy',
  keys = {
    {
      '[h',
      mode = 'n',
      function()
        require('vgit').hunk_up()
      end,
    },
    {
      ']h',
      mode = 'n',
      function()
        require('vgit').hunk_down()
      end,
    },
    {
      '<leader>hs',
      mode = 'n',
      function()
        require('vgit').buffer_hunk_stage()
      end,
    },
    {
      '<leader>hr',
      mode = 'n',
      function()
        require('vgit').buffer_hunk_reset()
      end,
    },
    {
      '<leader>hp',
      mode = 'n',
      function()
        require('vgit').buffer_hunk_preview()
      end,
    },
    {
      '<leader>hR',
      mode = 'n',
      function()
        require('vgit').buffer_reset()
      end,
    },
    {
      '<leader>hb',
      mode = 'n',
      function()
        require('vgit').buffer_blame_preview()
      end,
    },
    {
      '<leader>sp',
      mode = 'n',
      function()
        require('vgit').project_stash_preview()
      end,
    },
    {
      '<leader>lp',
      mode = 'n',
      function()
        require('vgit').project_logs_preview()
      end,
    },
    {
      '<leader>lb',
      mode = 'n',
      function()
        require('vgit').toggle_live_blame()
      end,
    },
    {
      '<leader>dp',
      mode = 'n',
      function()
        local state = require('no-neck-pain.state')
        if state.has_tabs(state) and state.is_active_tab_registered(state) then
          require('no-neck-pain').disable()
        end
        require('vgit').project_diff_preview()
      end,
    },
    -- { '<leader>bdp', mode = 'n', function() require('vgit').buffer_diff_preview() end },
    -- { '<leader>bhp', mode = 'n', function() require('vgit').buffer_history_preview() end },
    -- { '<leader>gx', mode = 'n', function() require('vgit').toggle_diff_preference() end },
  },
  opts = {
    settings = {
      hls = {
        GitAppBar = 'QuickfixLine',
        GitHeader = 'Keyword',
      },
      signs = {
        priority = 1337,
      },
    },
  },
}
