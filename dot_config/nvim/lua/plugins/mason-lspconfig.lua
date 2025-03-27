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
    require("mason-tool-installer").setup({
      ensure_installed = {
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
        "prettierd",
        "goimports",
        "stylua",
        "shfmt",
        "shellcheck",
      },
      auto_update = true,
    })

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

    require("mason").setup()
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

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { silent = true, wrap = false, title = "", focusable = false, border = "single" }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { silent = true, wrap = false, title = "", focusable = false, border = "single" }
    )

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = "angularls" })
        if client and client.name == "vtsls" and #angularLsClients > 0 then
          client.server_capabilities.referencesProvider = false
        end
      end,
    })

    local function lsp_rename()
      local rename_clients = {}

      for _, client in ipairs(vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })) do
        if client.supports_method("textDocument/rename") then
          table.insert(rename_clients, client.name)
        end
      end

      if vim.tbl_contains(rename_clients, "vtsls") and vim.tbl_contains(rename_clients, "angularls") then
        local new_rename_clients = {}
        for _, client_name in ipairs(rename_clients) do
          if client_name ~= "vtsls" then
            table.insert(new_rename_clients, client_name)
          end
        end
        rename_clients = new_rename_clients
      end

      if #rename_clients == 0 then
        vim.notify("No available LSP client for renaming.")
        return
      end

      if #rename_clients == 1 then
        vim.lsp.buf.rename(nil, { name = rename_clients[1] })
        return
      end

      table.sort(rename_clients, function(a, b)
        return a > b
      end)

      vim.ui.select(rename_clients, { prompt = "Select LSP client:" }, function(name)
        vim.lsp.buf.rename(nil, { name = name })
      end)
    end

    vim.keymap.set("n", "<leader>rn", lsp_rename)
  end,
}
