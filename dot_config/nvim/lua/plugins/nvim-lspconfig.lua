return {
  "neovim/nvim-lspconfig",
  ft = { "typescript", "typescriptreact" },
  config = function()
    local lspconfig = require("lspconfig")
    local filetype = vim.bo.filetype
    if filetype == "typescript" or filetype == "typescriptreact" then
      lspconfig.ts_ls.setup({})
    end
  end,
}
