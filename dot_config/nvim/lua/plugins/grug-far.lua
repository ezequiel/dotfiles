return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>gf",
      function()
        require("grug-far").open()
      end,
      mode = { "n", "x" },
    },
    {
      "<leader>gb",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "x" },
    },
    {
      "<leader>gw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      mode = { "n" },
    },
    {
      "<leader>gv",
      function()
        require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
      end,
      mode = { "x" },
    },
    {
      "<leader>g/",
      function()
        local search = vim.fn.getreg("/")
        -- surround with \b if "word" search (such as when pressing `*`)
        if search and vim.startswith(search, "\\<") and vim.endswith(search, "\\>") then
          search = "\\b" .. search:sub(3, -3) .. "\\b"
        end
        require("grug-far").open({
          prefills = {
            search = search,
          },
        })
      end,
      mode = { "n" },
    },
  },
  config = function(_, opts)
    require("grug-far").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function()
        vim.keymap.set({ "i" }, "<Enter>", "<Esc>", { buffer = true })
        -- vim.keymap.set({ "n" }, "o", "<Nop>", { noremap = true, buffer = true })
        -- vim.keymap.set({ "n" }, "O", "<Nop>", { noremap = true, buffer = true })
      end,
    })
  end,
  opts = {
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
      close = { n = "<C-c>" },
      gotoLocation = { n = "<enter>" },
      help = { n = "?" },
      historyAdd = false,
      historyOpen = false,
      openLocation = false,
      openNextLocation = false,
      openPrevLocation = false,
      pickHistoryEntry = false,
      previewLocation = false,
      qflist = { n = "<C-q>" },
      refresh = { n = "R" },
      replace = false,
      swapEngine = false,
      swapReplacementInterpreter = false,
      syncLine = { n = "<localleader>l" },
      syncLocations = { n = "<localleader>s" },
      toggleShowCommand = false,
    },

    -- engines = {
    --   ripgrep = {
    --     extraArgs = "",
    --   },
    -- },
  },
}
