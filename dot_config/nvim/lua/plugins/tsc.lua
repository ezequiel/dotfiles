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
      use_diagnostics = true,
      auto_open_qflist = false,
      auto_close_qflist = false,
      enable_progress_notifications = false,
      -- use_trouble_qflist = true,
      -- bin_path = require("lspconfig").util.root_pattern("package.json", ".git"),
      -- bin_path = require("tsc.utils").find_tsc_bin(),
      -- pretty_errors = true,
      flags = {
        -- watch = true,
        noEmit = true,
      },
    })

    vim.cmd("TSC")
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      callback = function()
        vim.cmd("TSC")
      end,
    })
  end,
}
