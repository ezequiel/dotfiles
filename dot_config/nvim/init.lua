vim.loader.enable()

vim.cmd([[
  let g:loaded_gzip = v:true
  let g:loaded_netrw = v:true
  let g:loaded_netrwPlugin = v:true
  let g:loaded_remote_plugins = v:true
  let g:loaded_tarPlugin = v:true
  let g:loaded_tutor_mode_plugin = v:true
  let g:loaded_zipPlugin = v:true
  let g:loaded_man = v:true
  let g:loaded_remote_file_loader = v:true
  let g:loaded_spellfile_plugin = v:true
  let g:loaded_shada_plugin = v:true
  let g:loaded_2html_plugin = v:true
  let g:editorconfig = v:false
  let g:did_install_default_menus = v:true
  let g:did_install_syntax_menu = v:true
]])

vim.diagnostic.config({
  signs = {
    active = true,
    text = {
      [vim.diagnostic.severity.ERROR] = '●',
      [vim.diagnostic.severity.WARN] = '●',
      [vim.diagnostic.severity.HINT] = '●',
      [vim.diagnostic.severity.INFO] = '●',
    },
  },
  float = {
    source = true,
    wrap = false,
  },
  underline = false,
  severity_sort = true,
  update_in_insert = false,
})

----------------------------------------------------
----------------------------------------------------

local augroup = vim.api.nvim_create_augroup('my-config', { clear = false })

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'help', 'checkhealth', 'qf' },
  callback = function()
    vim.keymap.set('n', '<C-c>', '<cmd>close!<CR>', { buffer = true })
  end,
})

vim.keymap.set({ 'n', 'i', 'x' }, '<C-c>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', true)
  vim.schedule(function()
    vim.cmd('fclose!')
  end)
  return '<C-c>'
end, { silent = true, expr = true })

----------------------------------------------------
----------------------------------------------------

local session = '/tmp/_session_restart.vim'

vim.keymap.set('n', '<D-r>', function()
  vim.cmd.mksession({ session, bang = true })
  vim.cmd.restart()
end)

vim.api.nvim_create_autocmd('VimEnter', {
  group = augroup,
  callback = vim.schedule_wrap(function()
    if not vim.uv.fs_stat(session) then
      return
    end
    vim.cmd.source(session)
    vim.fs.rm(session)
  end),
})

----------------------------------------------------
----------------------------------------------------

vim.keymap.set('n', '+', '<C-a>', { noremap = true })
vim.keymap.set('n', '-', '<C-x>', { noremap = true })
vim.keymap.set('n', '<c-q>', '<cmd>q<cr>')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', 'vv', 'V')
vim.keymap.set('n', '<C-W>|', '<C-W>v')
vim.keymap.set('n', '<C-W>-', '<C-W>s')
vim.keymap.set('n', '[z', '[z^')
vim.keymap.set('n', ']z', ']z^')
vim.keymap.set('n', '[c', function()
  pcall(function()
    vim.cmd('?' .. '^=======$')
  end)
end)
vim.keymap.set('n', ']c', function()
  pcall(function()
    vim.cmd('/' .. '^=======$')
  end)
end)
vim.keymap.set('n', '<leader>go', function()
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.fn.expand('<cword>')))
end)
vim.keymap.set('x', '<leader>go', function()
  vim.ui.open(
    ('https://google.com/search?q=%s'):format(
      vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }), ' '))
    )
  )
end)
vim.keymap.set({ 'n', 't' }, '<leader>zo', function()
  if vim.t.zoomed and vim.t.zoom_winrestcmd then
    vim.cmd(vim.t.zoom_winrestcmd)
    vim.t.zoomed = false
  else
    vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
    vim.cmd('resize | vertical resize')
    vim.t.zoomed = true
  end
end)
vim.keymap.set('n', '<leader>ds', function()
  vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR })
end)
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float)
vim.keymap.set('n', '<D-S-j>', "<cmd>execute 'move .+' . v:count1<cr>==")
vim.keymap.set('n', '<D-S-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==")
vim.keymap.set('i', '<D-S-j>', '<esc><cmd>m .+1<cr>==gi')
vim.keymap.set('i', '<D-S-k>', '<esc><cmd>m .-2<cr>==gi')
vim.keymap.set('v', '<D-S-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv")
vim.keymap.set('v', '<D-S-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv")
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ wrap = false, count = -1 })
end)
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ wrap = false, count = 1 })
end)

----------------------------------------------------
----------------------------------------------------

vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)
vim.opt.cmdheight = 0
vim.opt.ignorecase = true
vim.opt.modified = true
vim.opt.mouse = ''
vim.opt.ruler = false
vim.opt.shortmess:append('I')
vim.opt.signcolumn = 'yes:2'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.stl = "%{repeat('─',winwidth('.'))}"
vim.opt.wrap = false
vim.opt.pumheight = 10
vim.opt.winborder = 'single'
vim.opt.pumborder = 'single'
-- vim.opt.wrapscan = false

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/folke/tokyonight.nvim',
})

require('tokyonight').setup({
  style = 'night',
  plugins = {
    auto = true,
  },
})

vim.cmd('colorscheme tokyonight')
vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#16161e', bg = '#1a1b26' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#16161e', bg = '#1a1b26' })

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/Darazaki/indent-o-matic',
})

require('indent-o-matic').setup({})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

require('fzf-lua').setup({
  keymap = {
    fzf = {
      ['ctrl-q'] = 'select-all+accept',
      ['ctrl-d'] = 'half-page-down',
      ['ctrl-u'] = 'half-page-up',
    },
  },
  defaults = {
    hidden = true,
    follow = true,
    git_icons = false,
    file_icons = false,
  },
  grep = {
    rg_glob = true,
    glob_flag = '--iglob',
    glob_separator = '%s%-%-',
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
  },
  winopts = {
    preview = {
      layout = 'vertical',
    },
    treesitter = {
      enabled = false,
    },
  },
})

require('fzf-lua').register_ui_select()

vim.keymap.set('n', '<D-k>', require('fzf-lua').global)
vim.keymap.set('n', '<leader>re', require('fzf-lua').resume)
vim.keymap.set('n', '<leader>gs', require('fzf-lua').git_status)
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
vim.keymap.set('n', '<leader>fr', function()
  require('fzf-lua').oldfiles({ include_current_session = true, cwd_only = true })
end)
vim.keymap.set('n', '<leader>rg', require('fzf-lua').live_grep)
vim.keymap.set('n', '<leader>rw', require('fzf-lua').grep_cword)
vim.keymap.set('x', '<leader>rv', require('fzf-lua').grep_visual)
vim.keymap.set({ 'x', 'n' }, '<leader>rb', require('fzf-lua').blines)
vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions)
vim.keymap.set('n', 'gr', require('fzf-lua').lsp_references)
vim.keymap.set('n', 'gi', require('fzf-lua').lsp_implementations)
vim.keymap.set('n', 'gt', require('fzf-lua').lsp_typedefs)
vim.keymap.set('n', 'gic', require('fzf-lua').lsp_incoming_calls)
vim.keymap.set('n', 'goc', require('fzf-lua').lsp_outgoing_calls)
vim.keymap.set('i', '<c-x><c-f>', require('fzf-lua').complete_file)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/folke/sidekick.nvim',
})

require('sidekick').setup({
  nes = {
    enabled = false,
  },
  cli = {
    picker = 'fzf-lua',
    win = {
      keys = {
        hide_n = { '<c-c>', 'hide' },
        hide_ctrl_q = { '<c-c>', 'hide' },
        hide_ctrl_dot = { '<c-c>', 'hide', mode = 'nt' },
        hide_ctrl_z = { '<c-c>', 'hide', mode = 'nt' },
      },
    },
  },
})

vim.keymap.set({ 'n', 't' }, '<leader>ot', function()
  require('sidekick.cli').toggle({ name = 'opencode' })
end)

vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
  require('sidekick.cli').send({ name = 'opencode', focus = true, msg = '{this}' })
end)

vim.keymap.set('n', '<leader>oA', function()
  require('sidekick.cli').send({ name = 'opencode', focus = true, msg = '{file}' })
end)

vim.keymap.set({ 'n', 'x' }, '<leader>os', require('sidekick.cli').prompt)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/assistcontrol/readline.nvim',
})

vim.keymap.set({ '!', 'n' }, '<M-b>', require('readline').backward_word)
vim.keymap.set({ '!', 'n' }, '<M-f>', require('readline').forward_word)
vim.keymap.set({ '!', 'n', 'x' }, '<C-a>', require('readline').dwim_beginning_of_line)
vim.keymap.set({ '!', 'n', 'x' }, '<C-e>', require('readline').end_of_line)
vim.keymap.set({ 'n', 'x' }, '0', require('readline').dwim_beginning_of_line)
vim.keymap.set('!', '<M-BS>', require('readline').backward_kill_word)
vim.keymap.set('!', '<C-k>', require('readline').kill_line)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/jake-stewart/multicursor.nvim',
})

local mc = require('multicursor-nvim')
mc.setup()
mc.addKeymapLayer(function(set)
  set({ 'n', 'x' }, '<left>', mc.prevCursor)
  set({ 'n', 'x' }, '<right>', mc.nextCursor)
  set({ 'n', 'x' }, '<BS>', mc.deleteCursor)
  set('n', '<esc>', function()
    if not mc.cursorsEnabled() then
      mc.enableCursors()
    else
      mc.clearCursors()
    end
  end)
  set('n', '<c-c>', function()
    if not mc.hasCursors() then
      return
    end
    mc.clearCursors()
  end)
end)

vim.keymap.set('n', '<D-Up>', function()
  require('multicursor-nvim').lineAddCursor(-1, { skipEmpty = false })
end)
vim.keymap.set('n', '<D-Down>', function()
  require('multicursor-nvim').lineAddCursor(1, { skipEmpty = false })
end)
vim.keymap.set('n', '<D-S-Up>', function()
  require('multicursor-nvim').lineSkipCursor(-1, { skipEmpty = false })
end)
vim.keymap.set('n', '<D-S-Down>', function()
  require('multicursor-nvim').lineSkipCursor(1, { skipEmpty = false })
end)
vim.keymap.set('n', '@@', require('multicursor-nvim').toggleCursor)
vim.keymap.set('x', 'I', require('multicursor-nvim').insertVisual)
vim.keymap.set('x', 'A', require('multicursor-nvim').appendVisual)
vim.keymap.set({ 'n', 'x' }, '<leader>ma', require('multicursor-nvim').matchAllAddCursors)
vim.keymap.set('n', '<leader>A', require('multicursor-nvim').searchAllAddCursors)
vim.keymap.set('x', 'M', require('multicursor-nvim').matchCursors)
vim.keymap.set('x', '<leader>M', function()
  local pattern = vim.fn.getreg('"')
  require('multicursor-nvim').matchCursors(pattern)
end)
vim.keymap.set('n', '<leader>gv', require('multicursor-nvim').restoreCursors)

----------------------------------------------------
----------------------------------------------------

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function(event)
    local data = event.data
    if not (data.spec.name == 'nvim-redraft' and (data.kind == 'install' or data.kind == 'update')) then
      return
    end
    vim.system({ 'bash', '-c', 'npm ci --ignore-scripts && npm run build' }, {
      cwd = data.path .. '/ts',
    })
  end,
})

vim.pack.add({
  'https://github.com/jim-at-jibba/nvim-redraft',
})

require('nvim-redraft').setup({
  llm = { provider = 'copilot' },
})

vim.keymap.set('x', '<leader>aa', require('nvim-redraft').edit)

vim.keymap.set('n', '<leader>aa', function()
  vim.cmd('normal! V')
  require('nvim-redraft').edit()
end)

----------------------------------------------------
----------------------------------------------------

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
    grep_in_directory = 'fzf-lua',
    grep_in_selected_files = 'fzf-lua',
    picker_add_copy_relative_path_action = 'fzf-lua',
  },
})

vim.keymap.set('n', '<leader>yy', '<cmd>Yazi<CR>')
vim.keymap.set('n', '<leader>yt', '<cmd>Yazi toggle<CR>')
vim.keymap.set('n', '<leader>bd', function()
  require('yazi.utils').bufdelete('bundled-snacks', vim.api.nvim_get_current_buf())
end)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/JoosepAlviste/nvim-ts-context-commentstring',
  'https://github.com/numToStr/Comment.nvim',
})
require('Comment').setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/okuuva/auto-save.nvim',
})
require('auto-save').setup({
  write_all_buffers = true,
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/stevearc/conform.nvim',
})
require('conform').setup({
  formatters_by_ft = {
    ['*'] = { 'trim_newlines', 'trim_whitespace' },
    css = { 'prettier' },
    dockerfile = { 'dockerfmt' },
    go = { 'goimports' },
    html = { 'prettier' },
    htmlangular = { 'prettier' },
    javascript = { 'prettier' },
    javascriptreact = { 'prettier' },
    json = { 'prettier' },
    jsonc = { 'prettier' },
    lua = { 'stylua' },
    markdown = { 'prettier' },
    scss = { 'prettier' },
    typescript = { 'prettier' },
    typescriptreact = { 'prettier' },
    yaml = { 'yamlfmt' },
    toml = { 'taplo' },
    sh = { 'shellcheck', 'shfmt' },
    bash = { 'shellcheck', 'shfmt' },
    zsh = { 'shellcheck', 'shfmt' },
  },
  notify_on_error = false,
  log_level = vim.log.levels.OFF,
  default_format_opts = {
    quiet = true,
    async = true,
    undojoin = true,
  },
  format_after_save = {},
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/kwkarlwang/bufjump.nvim',
})
require('bufjump').setup({
  forward_key = '<D-]>',
  backward_key = '<D-[>',
  on_success = false,
  forward_same_buf_key = '<C-S-I>',
  backward_same_buf_key = '<C-S-O>',
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/kylechui/nvim-surround',
})
require('nvim-surround').setup()

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/zbirenbaum/copilot.lua',
})
require('copilot').setup({
  server_opts_overrides = {
    settings = {
      telemetry = {
        telemetryLevel = 'off',
      },
      advanced = {
        listCount = 1,
        inlineSuggestCount = 1,
      },
    },
  },
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = '<tab>',
      dismiss = false,
      next = false,
      prev = false,
    },
  },
  panel = { enabled = false },
  nes = { enabled = false },
  server = {
    type = 'nodejs',
    custom_server_filepath = vim.env.XDG_DATA_HOME
      .. '/mise/installs/npm-github-copilot-language-server/latest/bin/copilot-language-server',
  },
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/djoshea/vim-autoread',
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/rachartier/tiny-glimmer.nvim',
})

require('tiny-glimmer').setup({
  overwrite = {
    search = {
      enabled = false,
    },
    undo = {
      enabled = true,
    },
    redo = {
      enabled = true,
    },
  },
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/kevinhwang91/promise-async',
  'https://github.com/kevinhwang91/nvim-ufo',
})

vim.opt.foldcolumn = '0'
vim.opt.foldlevel = 1337
vim.opt.foldlevelstart = 1337
vim.opt.foldenable = true

require('ufo').setup({
  provider_selector = function()
    return { 'indent' }
  end,
})

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/stevearc/quicker.nvim',
})

require('quicker').setup({
  edit = {
    enabled = false,
  },
  trim_leading_whitespace = false,
  keys = {
    {
      'r',
      function()
        require('quicker').refresh()
      end,
    },
    {
      '>',
      function()
        require('quicker').expand({ before = 2, after = 2, add_to_existing = true })
      end,
    },
    {
      '<',
      function()
        require('quicker').collapse()
      end,
    },
    {
      'q',
      function()
        require('quicker').close()
      end,
    },
  },
})

vim.keymap.set('n', '<leader>qf', function()
  require('quicker').toggle({ focus = true, open_cmd_mods = { split = 'botright' } })
end)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/MagicDuck/grug-far.nvim',
})

require('grug-far').setup({
  folding = { enabled = false },
  resultLocation = { showNumberLabel = false },
  wrap = false,
  keymaps = {
    abort = false,
    applyNext = false,
    applyPrev = false,
    close = { n = '<c-c>' },
    gotoLocation = { n = '<enter>' },
    help = { n = '?' },
    historyAdd = false,
    historyOpen = false,
    nextInput = { n = '<tab>' },
    openLocation = false,
    openNextLocation = false,
    openPrevLocation = false,
    pickHistoryEntry = false,
    prevInput = { n = '<s-tab>' },
    previewLocation = false,
    qflist = { n = '<C-q>' },
    refresh = { n = 'r' },
    replace = { n = '<localleader>rr' },
    swapEngine = { n = '<localleader>ee' },
    swapReplacementInterpreter = false,
    syncFile = { n = '<localleader>sf' },
    syncLine = { n = '<localleader>sl' },
    syncLocations = { n = '<localleader>sa' },
    syncNext = false,
    syncPrev = false,
    toggleShowCommand = false,
  },
})

vim.keymap.set('n', '<leader>gf', require('grug-far').open)

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'grug-far',
  callback = function()
    vim.opt.signcolumn = 'no'
    vim.keymap.set('i', '<CR>', '<cmd>stopinsert<CR>', { buffer = true })
  end,
})
vim.keymap.set('n', '<leader>gb', function()
  require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })
end)
vim.keymap.set('n', '<leader>gw', function()
  require('grug-far').open({
    prefills = {
      flags = '--case-sensitive',
      search = '\\b' .. vim.fn.expand('<cword>') .. '\\b',
    },
  })
end)
vim.keymap.set('x', '<leader>gv', function()
  require('grug-far').open({
    prefills = {
      search = vim.fn.getreg('/'),
      flags = '--case-sensitive',
    },
  })
end)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/rapan931/lasterisk.nvim',
  'https://github.com/kevinhwang91/nvim-hlslens',
})

require('hlslens').setup({
  calm_down = {
    default = true,
  },
  nearest_only = {
    default = true,
  },
  virt_priority = 1,
  override_lens = function(render, posList, nearest, idx, _)
    local lnum, col = unpack(posList[idx])
    local cnt = #posList
    local text = ('[%d/%d]'):format(idx, cnt)
    local chunks
    if nearest then
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
    else
      chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
    end
    render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
  end,
})

vim.keymap.set('n', 'n', function()
  local count = vim.v.count1
  local key = (count > 1 and count or '') .. 'n'
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
  require('hlslens').start()
end)
vim.keymap.set('n', 'N', function()
  local count = vim.v.count1
  local key = (count > 1 and count or '') .. 'N'
  local keys = vim.api.nvim_replace_termcodes(key, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
  require('hlslens').start()
end)
vim.keymap.set('n', '*', function()
  require('lasterisk').search({ is_whole = true })
  require('hlslens').start()
end)
vim.keymap.set('x', '*', function()
  require('lasterisk').search({ is_whole = false })
  require('hlslens').start()
end)

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/arnamak/stay-centered.nvim',
})

require('stay-centered').setup({
  allow_scroll_move = false,
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

local lsp_opts = {
  bashls = {
    filetypes = { 'sh', 'zsh' },
  },
  dockerls = {},
  eslint = {
    filetypes = {
      'html',
      'htmlangular',
      'javascript',
      'javascriptreact',
      'json',
      'jsonc',
      'typescript',
      'typescriptreact',
    },
    settings = {
      experimental = {
        useFlatConfig = true,
      },
      run = 'onSave',
      workingDirectory = {
        mode = 'auto',
      },
    },
  },
  golangci_lint_ls = {
    init_options = {
      command = {
        'golangci-lint',
        'run',
        '--fast',
        '--out-format=json',
        '--show-stats=false',
        '--issues-exit-code=1',
      },
    },
  },
  gopls = {},
  html = {},
  jsonls = {},
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          enable = true,
        },
        diagnostics = {
          enable = true,
          globals = { 'vim' },
        },
        format = {
          enable = false,
        },
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        telemetry = { enable = false },
        workspace = {
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    },
  },
  marksman = {},
  tailwindcss = {
    settings = { tailwindCSS = { colorDecorators = false } },
  },
  vtsls = {
    settings = {
      vtsls = {
        autoUseWorkspaceTsdk = true,
        experimental = {
          completion = {
            enableServerSideFuzzyMatch = true,
            entriesLimit = 10,
          },
        },
      },
      typescript = {
        tsserver = {
          experimental = {
            -- NOTE: Some projects will crawl to a halt when this is enabled
            -- enableProjectDiagnostics = true,
          },
          maxTsServerMemory = 8192,
        },
        preferences = {
          importModuleSpecifier = 'non-relative',
        },
        updateImportsOnFileMove = 'always',
      },
      javascript = {
        preferences = {
          importModuleSpecifier = 'non-relative',
        },
        updateImportsOnFileMove = 'always',
      },
    },
  },
  yamlls = {},
}

for name, opts in pairs(lsp_opts) do
  vim.lsp.config(name, opts)
  vim.lsp.enable(name)
end

-- Angular LSP is extremely slow and lags everything
vim.keymap.set('n', '<leader>ng', function()
  vim.lsp.config('angularls', {
    workspace_required = true,
  })
  vim.lsp.enable('angularls')
end)

vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover({
    focusable = true,
    silent = true,
    wrap = false,
  })
end)

vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)

vim.keymap.set({ 'n', 'x' }, '<D-s-o>', function()
  vim.lsp.buf.selection_range(vim.v.count1)
end)

vim.keymap.set({ 'n', 'x' }, '<D-s-i>', function()
  vim.lsp.buf.selection_range(-vim.v.count1)
end)

vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  callback = function(event)
    local vtslsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'vtsls' })
    local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'angularls' })
    if #vtslsClients > 0 and #angularLsClients > 0 then
      vtslsClients[1].server_capabilities.referencesProvider = false
      vtslsClients[1].server_capabilities.renameProvider = false
    end
  end,
})

----------------------------------------------------
----------------------------------------------------

vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('gitsigns').setup({
  sign_priority = 1337,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
    virt_text_priority = 2,
  },
  update_debounce = 1000,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next', { wrap = false })
      end
    end)

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev', { wrap = false })
      end
    end)

    map('n', '<leader>hs', gitsigns.stage_hunk)

    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('v', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)

    map('n', '<leader>hR', gitsigns.reset_buffer)

    map('n', '<leader>hp', gitsigns.preview_hunk)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hd', gitsigns.diffthis)

    map('n', '<leader>hD', function()
      gitsigns.diffthis('~')
    end)

    map('n', '<leader>hQ', function()
      gitsigns.setqflist('all')
    end)

    map('n', '<leader>hq', gitsigns.setqflist)
  end,
})

----------------------------------------------------
----------------------------------------------------

vim.g.coq_settings = {
  auto_start = 'shut-up',
  xdg = true,
  match = { max_results = 10 },
  keymap = {
    bigger_preview = 'K',
    manual_complete_insertion_only = true,
    jump_to_mark = '',
  },
  clients = {
    buffers = { enabled = false },
    lsp_inline = { enabled = false },
    registers = { enabled = false },
    snippets = { enabled = false },
    tags = { enabled = false },
    third_party = { enabled = false },
    third_party_inline = { enabled = false },
    tmux = { enabled = false },
    tree_sitter = { enabled = false },
    paths = { enabled = false, resolution = { 'file' } },
  },
  completion = {
    always = false,
    sticky_manual = true,
  },
  display = {
    ghost_text = { enabled = false },
    preview = {
      enabled = true,
      border = 'single',
      positions = { north = 3, south = 2, west = 4, east = 1 },
    },
    statusline = { helo = false },
    icons = { mode = 'none' },
    mark_applied_notify = false,
  },
}

vim.api.nvim_create_autocmd('PackChanged', {
  group = augroup,
  callback = function(event)
    local data = event.data
    if not (data.spec.name == 'coq_nvim' and (data.kind == 'install' or data.kind == 'update')) then
      return
    end
    vim.schedule(function()
      vim.cmd('COQdeps')
    end)
  end,
})

vim.pack.add({ 'https://github.com/ms-jpq/coq_nvim' })

----------------------------------------------------
----------------------------------------------------

vim.pack.add({ 'https://github.com/trevorhauter/gitportal.nvim' })

require('gitportal').setup({ always_include_current_line = true })

vim.keymap.set({ 'n', 'x' }, '<leader>gy', require('gitportal').copy_link_to_clipboard)
vim.keymap.set({ 'n', 'x' }, '<leader>gh', require('gitportal').open_file_in_browser)

vim.keymap.set('n', 'gH', require('gitportal').open_file_in_neovim)

vim.api.nvim_create_user_command('Gh', function()
  vim.cmd('GitPortal open_link')
end, {
  nargs = '*',
  complete = 'command',
})

----------------------------------------------------
----------------------------------------------------

vim.cmd([[
  let g:vindent_block_ending = [ ')', ']', '}', 'end', 'else', 'elif' ]
  let g:vindent_infer	= 1
  let g:vindent_jumps = 1
  let g:vindent_motion_XX_se = ']s'
  let g:vindent_motion_XX_ss = '[s'
  let g:vindent_object_XX_aI = 'aI'
  let g:vindent_object_XX_ii = 'ii'
  let g:vindent_object_XX_ai = 'ai'
]])

vim.pack.add({ 'https://github.com/jessekelighine/vindent.vim' })
