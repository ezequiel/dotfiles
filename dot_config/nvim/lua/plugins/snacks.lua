return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  dependencies = {
    'Darazaki/indent-o-matic',
  },
  keys = {
    {
      '<leader>gh',
      function()
        Snacks.gitbrowse()
      end,
      mode = { 'n', 'x' },
      desc = 'Git Browse',
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
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files({ cwd = Snacks.git.get_root() })
      end,
    },
    {
      '<leader>fr',
      function()
        Snacks.picker.recent({
          filter = {
            cwd = Snacks.git.get_root(),
            paths = {
              [Snacks.git.get_root() .. '/.git/COMMIT_EDITMSG'] = false,
            },
          },
        })
      end,
      desc = 'Recent',
    },
    {
      '<S-D-a>',
      function()
        Snacks.picker.buffers()
      end,
    },
    {
      '<leader>rg',
      function()
        Snacks.picker.grep({ cwd = Snacks.git.get_root() })
      end,
    },
    {
      '<leader>rgw',
      function()
        Snacks.picker.grep_word({
          cwd = Snacks.git.get_root(),
        })
      end,
    },
    {
      '<leader>rgv',
      function()
        Snacks.picker.grep_word({
          cwd = Snacks.git.get_root(),
        })
      end,
      mode = 'x',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
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
    {
      '<leader>di',
      function()
        Snacks.toggle.dim():toggle()
      end,
      desc = 'Toggle dim',
    },
    {
      '<leader>zo',
      function()
        Snacks.toggle.zoom():toggle()
      end,
      desc = 'Toggle zoom',
    },
  },
  opts = {
    picker = {
      layout = {
        preset = 'ivy',
        fullscreen = true,
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
            ['<C-w>'] = false,
            ['<a-BS>'] = { '<c-s-w>', mode = { 'i' }, expr = true, desc = 'delete word' },
            ['<CR>'] = { 'confirm', mode = { 'n', 'i' } },
            ['<Down>'] = { 'list_down', mode = { 'i', 'n' } },
            ['<Esc>'] = 'cancel',
            ['<S-CR>'] = false,
            ['<S-Tab>'] = { 'select_and_prev', mode = { 'i', 'n' } },
            ['<Tab>'] = { 'select_and_next', mode = { 'i', 'n' } },
            ['<Up>'] = { 'list_up', mode = { 'i', 'n' } },
            ['<a-d>'] = false,
            ['<a-f>'] = false,
            ['<a-h>'] = false,
            ['<a-i>'] = false,
            ['<a-m>'] = false,
            ['<a-p>'] = false,
            ['<a-w>'] = false,
            ['<c-a>'] = false,
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
            ['<c-h>'] = { 'edit_split', mode = { 'i', 'n' } },
            ['<c-v>'] = { 'edit_vsplit', mode = { 'i', 'n' } },
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
            ['<Space>'] = false,
          },
        },
      },
    },
    bufdelete = { enabled = true },
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
    input = { enabled = true },
    terminal = {
      enabled = true,
      win = {
        keys = {
          term_normal = {
            '<esc>',
            function()
              return '<C-\\><C-n>'
            end,
            mode = 't',
            expr = true,
            desc = 'Double escape to normal mode',
          },
        },
      },
    },
    dim = { enabled = true },
    explorer = { enabled = false },
    rename = { enabled = false },
    lazygit = { enabled = false },
    animate = { enabled = false },
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    debug = { enabled = false },
    scope = { enabled = false },
    git = { enabled = false },
    image = { enabled = false },
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
}
