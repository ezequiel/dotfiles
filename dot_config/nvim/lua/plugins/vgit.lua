local function git_blame_current_line_or_selection()
  local mode = vim.fn.mode()
  local start_line, end_line

  if mode == 'v' or mode == 'V' or mode == '\22' then
    local _, start_lnum = unpack(vim.fn.getpos('v'))
    local _, end_lnum = unpack(vim.fn.getpos('.'))
    start_line = math.min(start_lnum, end_lnum)
    end_line = math.max(start_lnum, end_lnum)
  else
    start_line = vim.api.nvim_win_get_cursor(0)[1]
    end_line = start_line
  end

  local file = vim.api.nvim_buf_get_name(0)
  local root = Snacks.git.get_root()
  local cmd = {
    'git',
    '-C',
    root,
    'blame',
    '-L',
    start_line .. ',' .. end_line,
    '--porcelain',
    file,
  }

  local output = vim.fn.system(cmd)
  local commit_hashes = {}

  for line in output:gmatch('[^\r\n]+') do
    local hash = line:match('^([a-f0-9]+)%s+%d+%s+%d+%s+%d+')
    if hash then
      table.insert(commit_hashes, hash)
    end
  end

  return commit_hashes
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
        local commit_hashes = git_blame_current_line_or_selection()
        require('vgit').project_commits_preview(table.unpack(commit_hashes))
      end,
      mode = { 'n', 'x' },
    },
    {
      '[h',
      function()
        require('vgit').hunk_up()
      end,
    },
    {
      ']h',
      function()
        require('vgit').hunk_down()
      end,
    },
    {
      '<leader>hs',
      function()
        require('vgit').buffer_hunk_stage()
      end,
    },
    {
      '<leader>hr',
      function()
        require('vgit').buffer_hunk_reset()
      end,
    },
    {
      '<leader>hp',
      function()
        require('vgit').buffer_hunk_preview()
      end,
    },
    {
      '<leader>hR',
      function()
        require('vgit').buffer_reset()
      end,
    },
    {
      '<leader>bp',
      function()
        require('vgit').buffer_blame_preview()
      end,
    },
    {
      '<leader>bh',
      function()
        require('vgit').buffer_history_preview()
      end,
    },
    {
      '<leader>sp',
      function()
        require('vgit').project_stash_preview()
      end,
    },
    {
      '<leader>lp',
      function()
        require('vgit').project_logs_preview()
      end,
    },
    {
      '<leader>lb',
      function()
        require('vgit').toggle_live_blame()
      end,
    },
    {
      '<leader>dp',
      function()
        require('vgit').project_diff_preview()
      end,
    },
    {
      '<leader>bc',
      function()
        require('vgit').buffer_conflict_accept_both()
      end,
    },
    {
      '<leader>cc',
      function()
        require('vgit').buffer_conflict_accept_current()
      end,
    },
    {
      '<leader>ic',
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
      scene = {
        keymaps = {
          quit = '<C-c>',
        },
      },
      live_blame = {
        format = function(blame)
          local commit_message = blame.commit_message
          if not blame.committed then
            return
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

          return string.format('%s, %s, %s', time_string, string.match(blame.author_mail, '([^@]+)'), commit_message)
        end,
      },
    },
  },
}
