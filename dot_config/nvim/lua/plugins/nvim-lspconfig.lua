return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer",
    "saghen/blink.cmp",
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    "yioneko/nvim-vtsls",
  },
  config = function()
    require("mason-tool-installer").setup({
      ensure_installed = {
        "angularls",
        "bashls",
        "copilot-language-server",
        "css_variables",
        "cssls",
        "cssmodules_ls",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "goimports",
        "golangci_lint_ls",
        "gopls",
        "groovyls",
        "html",
        "jsonls",
        "marksman",
        "nginx_language_server",
        "prettierd",
        "shellcheck",
        "shfmt",
        "somesass_ls",
        "stylelint_lsp",
        "stylua",
        "vtsls",
        "yamlls",
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
  end,
  init = function()
    vim.keymap.set({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        focusable = false,
        silent = true,
        wrap = false,
        border = "single",
      })
    end)

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = "angularls" })
        if client and client.name == "vtsls" and #angularLsClients > 0 then
          client.server_capabilities.referencesProvider = false
        end
      end,
    })

    vim.keymap.set("n", "<leader>rn", function()
      local current_buf = vim.api.nvim_get_current_buf()
      local is_angularls_attached = #(vim.lsp.get_active_clients({ name = "angularls", bufnr = current_buf })) > 0
      local is_vtsls_attached = #(vim.lsp.get_active_clients({ name = "vtsls", bufnr = current_buf })) > 0

      if is_angularls_attached and is_vtsls_attached then
        vim.lsp.buf.rename(nil, { name = "angularls" })
        return
      end

      vim.lsp.buf.rename()
    end)
  end,
}
