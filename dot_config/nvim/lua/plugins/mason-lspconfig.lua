return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "saghen/blink.cmp",
    "williamboman/mason.nvim",
    "yioneko/nvim-vtsls",
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
    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = ensure_installed,
    })

    local lspconfig = require("lspconfig")

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    for _, server in ipairs(ensure_installed) do
      if not vim.tbl_contains({ "vtsls", "eslint", "stylelint_lsp", "golangci_lint_ls" }, server) then
        lspconfig[server].setup({
          capabilities = capabilities,
        })
      end
    end

    lspconfig.golangci_lint_ls.setup({
      capabilities = capabilities,
    })

    lspconfig.stylelint_lsp.setup({
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("package.json"),
    })

    lspconfig.vtsls.setup({
      capabilities = capabilities,
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
      workingDirectory = {
        mode = "auto",
      },
    })

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
