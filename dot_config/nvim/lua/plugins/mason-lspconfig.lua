return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer",
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "yioneko/nvim-vtsls",
  },
  config = function()
    local lsps = {
      "angularls",
      "bashls",
      "css_variables",
      "cssls",
      "cssmodules_ls",
      "docker_compose_language_service",
      "dockerls",
      "eslint",
      "golangci_lint_ls",
      "gopls",
      "groovyls",
      "html",
      "jsonls",
      "marksman",
      "nginx_language_server",
      "somesass_ls",
      "stylelint_lsp",
      "vtsls",
      "yamlls",
    }
    local other = { "prettierd", "goimports", "stylua", "shfmt", "shellcheck" }
    require("mason-tool-installer").setup({
      ensure_installed = vim.list_extend(lsps, other),
      auto_update = true,
    })

    require("mason").setup()

    local lsp_opts = {
      eslint = {
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "json",
          "jsonc",
        },
        workingDirectory = {
          mode = "auto",
        },
      },
      stylelint = {
        root_dir = require("lspconfig").util.root_pattern("package.json"),
      },
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
            enableMoveToFileCodeAction = true,
          },
          typescript = {
            updateImportsOnFileMove = {
              enabled = "always",
            },
            preferences = {
              includePackageJsonAutoImports = true,
              preferTypeOnlyAutoImports = true,
            },
          },
          javascript = {
            updateImportsOnFileMove = {
              enabled = "always",
            },
          },
        },
      },
    }

    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("blink.cmp").get_lsp_capabilities()
    )

    require("mason-lspconfig").setup({
      handlers = {
        function(name)
          local opts = lsp_opts[name] or {}
          opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
          require("lspconfig")[name].setup(opts)
        end,
      },
    })

    vim.keymap.set({ "n", "x" }, "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = "angularls" })
        if client and client.name == "vtsls" and #angularLsClients > 0 then
          client.server_capabilities.referencesProvider = false
        end
      end,
    })

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { silent = true, wrap = false, title = "", focusable = false, border = "single" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { silent = true, wrap = false, title = "", focusable = false, border = "single" }
    )
  end,
}
