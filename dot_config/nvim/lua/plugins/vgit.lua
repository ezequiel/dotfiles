local function git_blame_current_line()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local line = cursor[1]
  local file = vim.api.nvim_buf_get_name(0)
  local root = Snacks.git.get_root()
  local cmd = {
    'git',
    '-C',
    root,
    'blame',
    '-L',
    line .. ',' .. line,
    '--porcelain',
    file,
  }
  return vim.fn.system(cmd):match('^([a-f0-9]+)')
end

return {
  'tanvirtin/vgit.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>cp',
      function()
        require('vgit').project_commits_preview(git_blame_current_line())
      end,
    },
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
    {
      '<leader>ab',
      mode = 'n',
      function()
        require('vgit').buffer_conflict_accept_both()
      end,
    },
    {
      '<leader>cc',
      mode = 'n',
      function()
        require('vgit').buffer_conflict_accept_current()
      end,
    },
    {
      '<leader>ic',
      mode = 'n',
      function()
        require('vgit').buffer_conflict_accept_incoming()
      end,
    },
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
      live_blame = {
        format = function(blame)
          local commit_message = blame.commit_message
          if not blame.committed then
            return 'Uncommitted'
          end

          local seconds = os.difftime(os.time(), blame.author_time)
          local divisions = {
            { 60 * 60 * 24 * 365, 'y' }, -- years
            { 60 * 60 * 24 * 30, 'mo' }, -- months
            { 60 * 60 * 24 * 7, 'w' }, -- weeks
            { 60 * 60 * 24, 'd' }, -- days
            { 60 * 60, 'h' }, -- hours
            { 60, 'm' }, -- minutes
            { 1, 's' }, -- seconds
          }

          local time_string = 'now'
          for _, division in ipairs(divisions) do
            local unit_seconds, suffix = unpack(division)
            if seconds >= unit_seconds then
              local value = math.floor(seconds / unit_seconds + 0.5)
              time_string = string.format('%d%s', value, suffix)
              break
            end
          end

          return string.format('%s, %s, %s', time_string, string.match(blame.committer_mail, '([^@]+)'), commit_message)
        end,
      },
    },
  },
}
