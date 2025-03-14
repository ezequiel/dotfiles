return {
  "williamboman/mason-lspconfig.nvim",
  event = "VeryLazy",
  dependencies = {
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "gopls", "vtsls", "jsonls", "eslint" },
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    lspconfig.vtsls.setup({
      capabilities = capabilities,
      on_attach = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "AutoSaveWritePost",
          callback = function()
            vim.lsp.buf.code_action({
              apply = true,
              context = {
                only = {
                  ---@diagnostic disable-next-line: assign-type-mismatch
                  "source.addMissingImports.ts",
                  ---@diagnostic disable-next-line: assign-type-mismatch
                  "source.removeUnusedImports.ts",
                },
                diagnostics = {},
              },
            })
          end,
        })
      end,
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
            library = {
              vim.api.nvim_get_runtime_file("", true),
              vim.env.VIMRUNTIME,
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
              vim.fn.expand("~/.local/share/nvim/lazy"),
            },
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

    require("lspconfig").eslint.setup({
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
        "vue",
        "svelte",
        "astro",
        "json",
        "jsonc",
      },

      -- experimental = {
      --   useFlatConfig = true,
      -- },
      -- workingDirectory = {
      --   mode = "auto",
      -- },
    })
  end,
}
