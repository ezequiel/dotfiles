return {
  "neovim/nvim-lspconfig",
  ft = { "javascript", "json", "jsonc", "typescript", "typescriptreact", "lua" },
  config = function()
    local lspconfig = require("lspconfig")
    local filetype = vim.bo.filetype
    if filetype == "javascript" or filetype == "typescript" or filetype == "typescriptreact" then
      lspconfig.ts_ls.setup({
        init_options = {
          preferences = {
            disableSuggestions = true,
          },
        },
      })
      return
    end
    if filetype == "lua" then
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = vim.split(package.path, ";"),
            },
            diagnostics = {
              globals = { "vim", "Snacks" },
            },
            workspace = {
              library = { vim.api.nvim_get_runtime_file("", true), vim.env.VIMRUNTIME },
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })
      return
    end
    if filetype == "json" or filetype == "jsonc" then
      lspconfig.jsonls.setup({})
      return
    end
  end,
}
