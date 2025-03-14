return {
  "stevearc/conform.nvim",
  event = { { event = "User", pattern = "AutoSaveWritePost" } },
  opts = {
    formatters_by_ft = {
      ["*"] = { "trim_newlines", "trim_whitespace" },
      css = { "prettierd" },
      go = { "goimports", "gofmt" },
      html = { "prettierd" },
      javascript = { "prettierd" },
      javascriptreact = { "prettierd" },
      json = { "prettierd" },
      jsonc = { "prettierd" },
      lua = { "stylua" },
      markdown = { "prettierd" },
      typescript = { "prettierd" },
      typescriptreact = { "prettierd" },
      yaml = { "prettierd" },
    },
    formatters = {
      prettierd = {
        env = {
          PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
        },
      },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    log_level = vim.log.levels.ERROR,
    notify_on_error = true,
    notify_no_formatters = true,
  },
  config = function(_, opts)
    local conform = require("conform")
    conform.setup(opts)
    conform.format({ bufnr = vim.api.nvim_get_current_buf() })
    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      callback = function(stuff)
        conform.format({ bufnr = stuff.data.saved_buffer })
      end,
    })
  end,
}
