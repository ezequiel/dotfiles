return {
  "neovim/nvim-lspconfig",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  config = function()
    local lspconfig = require("lspconfig")
    local filetype = vim.bo.filetype
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    lspconfig.vtsls.setup({
      capabilities = capabilities,
      on_attach = function()
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
          pattern = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          callback = function()
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.removeUnusedImports.ts" } },
            })
            vim.lsp.buf.code_action({
              apply = true,
              context = { only = { "source.addMissingImports.ts" } },
            })
          end,
        })
      end,
      settings = {
        vtsls = {
          autoUseWorkspaceTsdk = true,
        },
        javascript = {
          updateImportsOnFileMove = { enabled = "always" },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = "always" },
        },
      },
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
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

    lspconfig.jsonls.setup({
      capabilities = capabilities,
    })
  end,
}
