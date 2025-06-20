return {
  'tanvirtin/vgit.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  config = function()
    require('vgit').setup({
      keymaps = {
        ['n [h'] = 'hunk_up',
        ['n ]h'] = 'hunk_down',
        ['n <leader>hs'] = 'buffer_hunk_stage',
        ['n <leader>hr'] = 'buffer_hunk_reset',
        ['n <leader>hp'] = 'buffer_hunk_preview',
        ['n <leader>hR'] = 'buffer_reset',
        ['n <leader>hb'] = 'buffer_blame_preview',
        ['n <leader>sp'] = 'project_stash_preview',
        ['n <leader>lp'] = 'project_logs_preview',
        ['n <leader>lb'] = 'toggle_live_blame',
        ['n <leader>dp'] = function()
          local state = require('no-neck-pain.state')
          if state.has_tabs(state) and state.is_active_tab_registered(state) then
            require('no-neck-pain').disable()
          end
          require('vgit').project_diff_preview()
        end,
        -- ['n <leader>bdp'] = 'buffer_diff_preview',
        -- ['n <leader>bhp'] = 'buffer_history_preview',
        -- ['n <leader>gx'] = function()
        --   require('vgit').toggle_diff_preference()
        -- end,
      },
      settings = {
        hls = {
          GitAppBar = 'QuickfixLine',
          GitHeader = 'Keyword',
        },
        signs = {
          priority = 1337,
        },
      },
    })
  end,
}
