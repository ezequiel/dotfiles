local function get_cwd()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')[1]
  if vim.v.shell_error ~= 0 then
    return ''
  end
  local slash_count = select(2, vim.fn.getcwd():gsub('^' .. vim.pesc(git_root), ''):gsub('/', '/'))
  return slash_count > 0 and ('..' .. ('/..'):rep(slash_count - 1)) or ''
end

return {
  'MagicDuck/grug-far.nvim',
  keys = {
    {
      '<leader>gf',
      function()
        require('grug-far').open({ prefills = { paths = get_cwd() } })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>gfb',
      function()
        require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })
      end,
      mode = { 'n', 'x' },
    },
    {
      '<leader>gfw',
      function()
        require('grug-far').open({
          prefills = {
            paths = get_cwd(),
            flags = '--case-sensitive',
            search = '\\b' .. vim.fn.expand('<cword>') .. '\\b',
          },
        })
      end,
      mode = { 'n' },
    },
    {
      '<leader>gfwb',
      function()
        require('grug-far').open({
          prefills = {
            flags = '--case-sensitive',
            search = '\\b' .. vim.fn.expand('<cword>') .. '\\b',
            paths = vim.fn.expand('%'),
          },
        })
      end,
      mode = { 'n' },
    },
    {
      '<leader>gfv',
      function()
        require('grug-far').open({
          prefills = {
            search = vim.fn.getreg('/'),
            flags = '--case-sensitive',
            paths = get_cwd(),
          },
        })
      end,
      mode = { 'x' },
    },
    {
      '<leader>gfvb',
      function()
        require('grug-far').open({
          prefills = {
            search = vim.fn.getreg('/'),
            flags = '--case-sensitive',
            paths = vim.fn.expand('%'),
          },
        })
      end,
      mode = { 'x' },
    },
  },
  config = function(_, opts)
    require('grug-far').setup(opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'grug-far',
      callback = function()
        vim.opt.signcolumn = 'no'
        -- vim.keymap.set({ 'i' }, '<Enter>', '<Esc>', { buffer = true })
      end,
    })
  end,
  opts = {
    icons = { enabled = false },
    resultLocation = {
      showNumberLabel = false,
    },
    startInInsertMode = false,
    transient = true,
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
      openLocation = false,
      openNextLocation = false,
      openPrevLocation = false,
      pickHistoryEntry = false,
      previewLocation = false,
      qflist = { n = '<C-q>' },
      refresh = { n = 'R' },
      replace = { n = '<localleader>rr' },
      swapEngine = { n = '<localleader>ee' },
      swapReplacementInterpreter = false,
      syncLine = false,
      syncLocations = false,
      toggleShowCommand = false,
    },
    filePathConceal = function(params)
      local len = #params.file_path
      local window_width = params.window_width - 2
      if len < params.window_width then
        return
      end

      local first_part_len = math.floor(window_width / 3)
      local delta = (len - window_width)

      return first_part_len, first_part_len + delta
    end,
    filePathConcealChar = '…',
    enabledEngines = { 'ripgrep', 'astgrep-rules' },
    -- engines = {
    --   ripgrep = {
    --     extraArgs = "",
    --   },
    -- },
  },
}
