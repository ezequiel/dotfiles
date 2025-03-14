return {
  "williamboman/mason-lspconfig.nvim",
  -- event = "VeryLazy",
  lazy = false,
  dependencies = {
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
  },
  config = function()
    require("mason").setup()
    local ensure_installed = {
      "angularls",
      "bashls",
      "css_variables",
      "cssls",
      "cssmodules_ls",
      "docker_compose_language_service",
      "dockerls",
      "eslint",
      "gopls",
      "groovyls",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "nginx_language_server",
      "somesass_ls",
      "stylelint_lsp",
      "vtsls",
      "yamlls",
    }
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = ensure_installed,
    })

    local lspconfig = require("lspconfig")
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    for _, server in ipairs(ensure_installed) do
      if not vim.tbl_contains({ "vtsls", "lua_ls", "eslint" }, server) then
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end

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
                  "source.removeUnusedImports.ts",
                },
                diagnostics = {},
              },
            })
          end,
        })
        vim.keymap.set({ "n" }, "<leader>ca", function()
          vim.lsp.buf.code_action({
            apply = true,
            context = {
              only = {
                ---@diagnostic disable-next-line: assign-type-mismatch
                "source.addMissingImports.ts",
              },
              diagnostics = {},
            },
          })
        end)
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
