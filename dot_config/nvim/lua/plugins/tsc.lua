return {
  "dmmulroy/tsc.nvim",
  keys = {
    {
      "tsc",
      function()
        local tsc = require("tsc")
        tsc.stop()
        tsc.run()
      end,
    },
  },
  opt = {
    use_trouble_qflist = true,
    use_diagnostics = false,
    auto_open_qflist = true,
    auto_close_qflist = false,
    enable_progress_notifications = true,
    -- auto_start_watch_mode = true,
    -- bin_path = require("lspconfig").util.root_pattern("package.json", ".git"),
    -- bin_path = require("tsc.utils").find_tsc_bin(),
    -- pretty_errors = true,
    flags = {
      watch = true,
      noEmit = true,
    },
  },
  config = true,
}
