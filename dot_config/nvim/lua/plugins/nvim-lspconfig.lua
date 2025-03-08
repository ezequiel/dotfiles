return {
  "neovim/nvim-lspconfig",
  ft = { "typescript", "typescriptreact", "lua" },
  config = function()
    local lspconfig = require("lspconfig")
    local filetype = vim.bo.filetype
    if filetype == "typescript" or filetype == "typescriptreact" then
      lspconfig.ts_ls.setup({})
    end
    if filetype == "lua" then
      lspconfig.lua_ls.setup({})
    end
  end,
}
