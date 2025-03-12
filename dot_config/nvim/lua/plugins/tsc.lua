return {
  "dmmulroy/tsc.nvim",
  ft = { "typescript", "typescriptreact" },
  keys = {
    {
      "<leader>ts",
      "<cmd>TSCOpen<cr>",
    },
  },
  config = function()
    require("tsc").setup({
      auto_start_watch_mode = false,
      use_trouble_qflist = true,
      use_diagnostics = true,
      auto_open_qflist = false,
      auto_close_qflist = true,
      enable_progress_notifications = true,

      -- bin_path = require("tsc.utils").find_tsc_bin(),
      -- auto_start_watch_mode = true,
      -- pretty_errors = true,
      -- run_as_monorepo = true,
      flags = {
        watch = true,
        noEmit = true,
        -- project = function()
        --   return require("tsc.utils").find_nearest_tsconfig()
        -- end,
      },
    })
    -- todo:  set the cwd before doing this
    vim.cmd("TSC")
  end,
}
