vim.pack.add({
  'https://github.com/ibhagwan/fzf-lua',
})

require('fzf-lua').setup({
  actions = {
    files = {
      ['ctrl-s'] = require('fzf-lua').actions.file_split,
      ['ctrl-v'] = require('fzf-lua').actions.file_vsplit,
    },
  },
  keymap = {
    fzf = {
      ['ctrl-d'] = 'half-page-down',
      ['ctrl-u'] = 'half-page-up',
    },
  },
  defaults = {
    prompt = '→ ',
    hidden = true,
    follow = true,
    git_icons = false,
    file_icons = false,
    file_ignore_patterns = { '%.git/' },
    actions = {
      ['enter'] = require('fzf-lua').actions.file_edit_or_qf,
      ['ctrl-q'] = {
        fn = require('fzf-lua').actions.file_sel_to_qf,
        prefix = 'select-all',
      },
      ['ctrl-i'] = { require('fzf-lua').actions.toggle_ignore },
    },
  },
  files = {
    cwd_prompt = false,
  },
  lsp = {
    code_actions = {
      previewer = false,
    },
  },
  grep = {
    rg_glob = true,
    rg_glob_fn = function(query, opts)
      local regex, flags = query:match('^(.-)%s%-%-(.*)$')
      return (regex or query), flags
    end,
    RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH,
  },
  history = { cwd_only = true },
  winopts = {
    on_create = function()
      vim.opt.timeoutlen = 0
    end,
    on_close = function()
      vim.opt.timeoutlen = 1000
    end,
    preview = {
      layout = 'vertical',
    },
    treesitter = {
      enabled = false,
    },
  },
})

require('fzf-lua').register_ui_select()

vim.keymap.set('n', '<leader>bi', require('fzf-lua').builtin)
vim.keymap.set('n', '<leader>re', require('fzf-lua').resume)
vim.keymap.set('n', '<leader>gs', require('fzf-lua').git_status)
vim.keymap.set('n', '<leader>ff', require('fzf-lua').files)
vim.keymap.set('n', '<leader>fb', require('fzf-lua').buffers)
vim.keymap.set('n', '<leader>fr', require('fzf-lua').history)
vim.keymap.set('n', '<leader>rg', require('fzf-lua').live_grep)
vim.keymap.set('n', '<leader>rw', function()
  require('fzf-lua').live_grep({
    query = vim.fn.expand('<cword>'),
    rg_opts = '-w ' .. require('fzf-lua').defaults.grep.rg_opts,
  })
end)
vim.keymap.set('x', '<leader>rv', function()
  local search =
    vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos('.'), vim.fn.getpos('v'), { type = vim.fn.mode() }), ' '))
  require('fzf-lua').live_grep({
    search = search,
    rg_opts = require('fzf-lua').defaults.grep.rg_opts,
  })
end)
vim.keymap.set({ 'x', 'n' }, '<leader>rb', require('fzf-lua').blines)
vim.keymap.set('n', 'gd', require('fzf-lua').lsp_definitions)
vim.keymap.set('n', 'gic', require('fzf-lua').lsp_incoming_calls)
vim.keymap.set('n', 'goc', require('fzf-lua').lsp_outgoing_calls)

vim.keymap.set('n', 'gri', require('fzf-lua').lsp_implementations)
vim.keymap.set('n', 'grr', require('fzf-lua').lsp_references)
vim.keymap.set('n', 'grt', require('fzf-lua').lsp_typedefs)
