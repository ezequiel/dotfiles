local function get_cwd()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')[1]
  if vim.v.shell_error ~= 0 then
    return vim.fn.getcwd()
  end
  return git_root
end

return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  dependencies = {
    'tpope/vim-sleuth',
  },
  keys = {
    {
      '<leader>qf',
      function()
        Snacks.picker.qflist()
      end,
      desc = 'Quickfix List',
    },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
      mode = { 'n', 'v' },
    },
    {
      '<leader>re',
      function()
        Snacks.picker.resume()
      end,
      desc = 'Resume',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files({ cwd = get_cwd() })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent()
      end,
      desc = 'Recent',
    },
    {
      '<leader>bb',
      function()
        Snacks.picker.buffers()
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>rg',
      function()
        Snacks.picker.grep({ cwd = get_cwd() })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>rgb',
      function()
        Snacks.picker.grep({
          dirs = { vim.fn.expand('%') },
        })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>rgw',
      function()
        Snacks.picker.grep_word({
          cwd = get_cwd(),
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { 'n' },
    },
    {
      '<leader>rgwb',
      function()
        Snacks.picker.grep_word({
          dirs = { vim.fn.expand('%') },
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { 'n' },
    },
    {
      '<leader>rgv',
      function()
        Snacks.picker.grep_word({
          cwd = get_cwd(),
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { 'x' },
    },
    {
      '<leader>rgvb',
      function()
        Snacks.picker.grep_word({
          dirs = { vim.fn.expand('%') },
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { 'x' },
    },
    {
      '<leader>rgbl',
      function()
        Snacks.picker.lines({
          matcher = {
            fuzzy = false,
          },
        })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<C-x>',
      function()
        Snacks.bufdelete()
        vim.cmd('close')
      end,
    },
    {
      'gd',
      function()
        Snacks.picker.lsp_definitions()
      end,
    },
    {
      'gr',
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
    },
    {
      'gi',
      function()
        Snacks.picker.lsp_implementations()
      end,
    },
    {
      'gt',
      function()
        Snacks.picker.lsp_type_definitions()
      end,
    },
  },
  opts = {
    explorer = {
      enabled = false,
    },
    picker = {
      layout = {
        cycle = false,
      },
      enabled = true,
      hidden = true,
      follow = true,
      sources = {
        files = {
          hidden = true,
          follow = true,
        },
      },
      -- matcher = { cwd_bonus = true, frecency = true, sort_empty = true },
      win = {
        list = {
          wo = {
            conceallevel = 0,
          },
        },
        input = {
          keys = {
            ['/'] = false,
            ['<C-Down>'] = false,
            ['<C-Up>'] = false,
            ['<C-c>'] = { 'close', mode = { 'i', 'x', 'n' } },
            ['<C-w>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
            ['<a-BS>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
            ['<CR>'] = { 'confirm', mode = { 'n', 'i' } },
            ['<Down>'] = { 'list_down', mode = { 'i', 'n' } },
            ['<Esc>'] = 'cancel',
            ['<S-CR>'] = false,
            ['<S-Tab>'] = false,
            ['<Tab>'] = false,
            ['<Up>'] = { 'list_up', mode = { 'i', 'n' } },
            ['<a-d>'] = false,
            ['<a-f>'] = false,
            ['<a-h>'] = false,
            ['<a-i>'] = false,
            ['<a-m>'] = false,
            ['<a-p>'] = false,
            ['<a-w>'] = false,
            ['<c-a>'] = { 'select_all', mode = { 'n', 'i' } },
            ['<c-b>'] = false,
            ['<c-d>'] = { 'list_scroll_down', mode = { 'i', 'n' } },
            ['<c-f>'] = false,
            ['<c-g>'] = { 'toggle_live', mode = { 'i', 'n' } },
            ['<c-j>'] = false,
            ['<c-k>'] = false,
            ['<c-q>'] = { 'qflist', mode = { 'i', 'n' } },
            ['<c-s>'] = false,
            ['<c-t>'] = false,
            ['<c-u>'] = { 'list_scroll_up', mode = { 'i', 'n' } },
            ['<c-v>'] = false,
            ['<c-r>#'] = false,
            ['<c-r>%'] = false,
            ['<c-r><c-a>'] = false,
            ['<c-r><c-f>'] = false,
            ['<c-r><c-l>'] = false,
            ['<c-r><c-p>'] = false,
            ['<c-r><c-w>'] = false,
            ['<c-w>H'] = false,
            ['<c-w>J'] = false,
            ['<c-w>K'] = false,
            ['<c-w>L'] = false,
            ['?'] = 'toggle_help_input',
            ['G'] = 'list_bottom',
            ['gg'] = 'list_top',
            ['j'] = 'list_down',
            ['k'] = 'list_up',
            ['<c-n>'] = { 'list_down', mode = { 'i', 'n' } },
            ['<c-p>'] = { 'list_up', mode = { 'i', 'n' } },
            ['q'] = 'close',
            ['<Space>'] = { 'select_and_next', mode = { 'i', 'n' } },
          },
        },
      },
    },
    bufdelete = { enabled = true },
    rename = { enabled = true },
    dim = {
      enabled = true,
      animate = {
        enabled = false,
      },
      scope = {
        siblings = false,
      },
      -- filter = function(buf)
      --   return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ''
      -- end,
    },
    gitbrowse = {
      enabled = true,
      url_patterns = {
        ['.*github.*%..+'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
      },
    },
    indent = {
      enabled = true,
      indent = { enabled = true },
      scope = { enabled = false },
      animate = { enabled = false },
      chunk = {
        enabled = true,
        char = {
          horizontal = '',
          arrow = '',
          corner_top = '╭ ',
          corner_bottom = '╰ ',
          vertical = '│ ',
        },
      },
    },
    terminal = {
      enabled = false,
    },
    lazygit = { enabled = false },
    animate = { enabled = false },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    scope = { enabled = false },
    git = { enabled = false },
    image = { enabled = false },
    input = { enabled = false },
    layout = { enabled = false },
    notifier = { enabled = false },
    notify = { enabled = false },
    profiler = { enabled = false },
    quickfile = { enabled = false },
    scratch = { enabled = false },
    scroll = { enabled = false },
    toggle = { enabled = false },
    util = { enabled = false },
    win = { enabled = false },
    words = { enabled = false },
    zen = { enabled = false },
    statuscolumn = { enabled = false },
  },
  init = function()
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        Snacks.toggle.line_number():map('<leader>nu')
        Snacks.toggle.dim():map('<leader>di')
        Snacks.toggle.zoom():map('<leader>zo')
      end,
    })
  end,
}
