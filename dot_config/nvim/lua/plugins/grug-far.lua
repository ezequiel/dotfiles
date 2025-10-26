local function get_cwd()
  local slash_count = select(2, vim.fn.getcwd():gsub('^' .. vim.pesc(Snacks.git.get_root()), ''):gsub('/', '/'))
  return slash_count > 0 and ('..' .. ('/..'):rep(slash_count - 1)) or ''
end

return {
  'MagicDuck/grug-far.nvim',
  keys = {
    {
      '<leader>gff',
      function()
        require('grug-far').open({ prefills = { paths = get_cwd() } })
      end,
    },
    {
      '<leader>gfb',
      function()
        require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })
      end,
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
      mode = 'x',
    },
  },
  opts = {
    icons = { enabled = false },
    resultLocation = {
      showNumberLabel = false,
    },
    startInInsertMode = true,
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
      nextInput = { n = '<tab>' },
      openLocation = false,
      openNextLocation = false,
      openPrevLocation = false,
      pickHistoryEntry = false,
      prevInput = { n = '<s-tab>' },
      previewLocation = false,
      qflist = { n = '<C-q>' },
      refresh = { n = 'R' },
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
    helpWindow = { border = 'single' },
    historyWindow = { border = 'single' },
    previewWindow = { border = 'single' },
  },
}
