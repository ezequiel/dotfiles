return {
  "MagicDuck/grug-far.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>gf",
      "<cmd>GrugFar<cr>",
    },
  },
  opts = {
    icons = {
      enabled = true,
      fileIconsProvider = "nvim-web-devicons",
    },
    debounceMs = 0,
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
