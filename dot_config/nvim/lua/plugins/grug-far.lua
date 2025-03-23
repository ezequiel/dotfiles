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
        require("grug-far").open({
          prefills = { flags = "--case-sensitive", search = "\\b" .. vim.fn.expand("<cword>") .. "\\b" },
        })
      end,
      mode = { "n" },
    },
    {
      "<leader>gwb",
      function()
        require("grug-far").open({
          prefills = {
            flags = "--case-sensitive",
            search = "\\b" .. vim.fn.expand("<cword>") .. "\\b",
            paths = vim.fn.expand("%"),
          },
        })
      end,
      mode = { "n" },
    },
    {
      "<leader>gv",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.getreg("/"),
            flags = "--case-sensitive",
            paths = vim.fn.expand("%"),
          },
        })
      end,
      mode = { "x" },
    },
    {
      "<leader>gvb",
      function()
        require("grug-far").open({
          prefills = {
            search = vim.fn.getreg("/"),
            flags = "--case-sensitive",
            paths = vim.fn.expand("%"),
          },
        })
      end,
      mode = { "x" },
    },
  },
  config = function(_, opts)
    require("grug-far").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function()
        vim.keymap.set({ "i" }, "<Enter>", "<Esc>", { buffer = true })
        vim.keymap.set({ "n", "x" }, "q", function()
          require("grug-far").close_instance()
        end, { buffer = true })
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
      close = { n = "<c-c>" },
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
      replace = { n = "r" },
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
