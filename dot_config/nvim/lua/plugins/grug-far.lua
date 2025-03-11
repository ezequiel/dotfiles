return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>gf",
      function()
        require("grug-far").open()
      end,
      mode = { "n", "v", "x", "o" },
    },
    {
      "<leader>gb",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "v", "x", "o" },
    },
  },
  config = function(_, opts)
    require("grug-far").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "grug-far",
      callback = function()
        vim.keymap.set({ "n" }, "<Esc>", "<Cmd>stopinsert | bd!<CR>", { buffer = true })
        vim.keymap.set({ "i" }, "<Enter>", "<Esc>")
      end,
    })
  end,
  opts = {
    resultLocation = {
      showNumberLabel = false,
    },
    transient = true,
    -- engines = {
    --   ripgrep = {
    --     extraArgs = "",
    --   },
    -- },
  },
}
