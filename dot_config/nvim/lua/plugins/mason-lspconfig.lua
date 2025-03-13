return {
  "williamboman/mason-lspconfig.nvim",
  lazy = false,
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
