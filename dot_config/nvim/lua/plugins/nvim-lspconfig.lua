return {
  "neovim/nvim-lspconfig",
  ft = { "javascript", "json", "jsonc", "typescript", "typescriptreact", "lua" },
  config = function()
    local lspconfig = require("lspconfig")
    local filetype = vim.bo.filetype
    if filetype == "javascript" or filetype == "typescript" or filetype == "typescriptreact" then
      lspconfig.ts_ls.setup({})
      return
    end
    if filetype == "lua" then
      lspconfig.lua_ls.setup({})
      return
    end
    if filetype == "json" or filetype == "jsonc" then
      lspconfig.jsonls.setup({})
      return
    end
  end,
}
