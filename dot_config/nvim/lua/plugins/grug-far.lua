return {
  "MagicDuck/grug-far.nvim",
  keys = {
    {
      "<leader>gf",
      "<cmd>GrugFar<cr>",
    },
  },
  opts = {
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
