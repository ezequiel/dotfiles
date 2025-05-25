return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer',
    'saghen/blink.cmp',
    'mason-org/mason-lspconfig.nvim',
    'mason-org/mason.nvim',
    {
      'yioneko/nvim-vtsls',
      config = function()
        require('lspconfig.configs').vtsls = require('vtsls').lspconfig
      end,
    },
    {
      'luckasRanarison/tailwind-tools.nvim',
      name = 'tailwind-tools',
      build = ':UpdateRemotePlugins',
      dependencies = {
        'nvim-treesitter/nvim-treesitter',
      },
      opts = {
        document_color = {
          enabled = false,
        },
      },
    },
  },
  config = function()
    require('mason-tool-installer').setup({
      ensure_installed = {
        'angularls',
        'bashls',
        'copilot-language-server',
        'css_variables',
        'cssls',
        'cssmodules_ls',
        'docker_compose_language_service',
        'dockerls',
        'eslint',
        'goimports',
        'golangci_lint_ls',
        'gopls',
        'groovyls',
        'html',
        'jsonls',
        'marksman',
        'nginx_language_server',
        'shellcheck',
        'shfmt',
        'somesass_ls',
        'stylua',
        'vtsls',
        'yamlls',
        'tailwindcss-language-server',
      },
      auto_update = true,
    })

    local lsp_opts = {
      golangci_lint_ls = {
        init_options = {
          command = {
            'golangci-lint',
            'run',
            '--fast',
            '--out-format=json',
            '--show-stats=false',
            '--issues-exit-code=1',
          },
        },
      },
      eslint = {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'json', 'jsonc' },
        settings = {
          experimental = {
            useFlatConfig = true,
          },
          workingDirectory = {
            mode = 'auto',
          },
        },
      },
      angularls = {
        root_dir = function(fname)
          local util = require('lspconfig.util')
          return util.root_pattern('angular.json', 'nx.json')(fname)
        end,
      },
      vtsls = {
        settings = {
          refactor_auto_rename = true,
          vtsls = {
            enableMoveToFileCodeActions = true,
            autoUseWorkspaceTsdk = true,
            experimental = {
              completion = {
                enableServerSideFuzzyMatch = true,
              },
            },
          },
          typescript = {
            inlayHints = {
              parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = false },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            reportStyleChecksAsWarnings = false,
            format = {
              enable = false,
            },
            tsserver = {
              experimental = {
                enableProjectDiagnostics = true,
              },
            },
            preferences = {
              includePackageJsonAutoImports = true,
              importModuleSpecifier = 'non-relative',
              importModuleSpecifierPreference = 'non-relative',
              preferTypeOnlyAutoImports = false,
            },
            updateImportsOnFileMove = 'always',
            -- updateImportsOnFileMove = {
            --   enabled = 'always',
            -- },
          },
          javascript = {
            inlayHints = {
              parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = false },
              parameterTypes = { enabled = true },
              variableTypes = { enabled = true, suppressWhenTypeMatchesName = false },
              propertyDeclarationTypes = { enabled = true },
              functionLikeReturnTypes = { enabled = true },
              enumMemberValues = { enabled = true },
            },
            format = {
              enable = false,
            },
            preferences = {
              includePackageJsonAutoImports = true,
              importModuleSpecifier = 'non-relative',
              importModuleSpecifierPreference = 'non-relative',
            },
            updateImportsOnFileMove = 'always',
            -- updateImportsOnFileMove = {
            --   enabled = 'always',
            -- },
          },
        },
      },
    }

    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('blink.cmp').get_lsp_capabilities()
    )

    for name, opts in pairs(lsp_opts) do
      opts = opts or {}
      opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
      vim.lsp.config(name, opts)
    end

    require('mason').setup()
    require('mason-lspconfig').setup()
  end,
  init = function()
    vim.keymap.set({ 'n', 'x' }, '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({
        focusable = true,
        silent = true,
        wrap = false,
      })
    end)

    vim.api.nvim_create_autocmd('LspAttach', {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'angularls' })
        if client and client.name == 'vtsls' and #angularLsClients > 0 then
          client.server_capabilities.referencesProvider = false
        end

        vim.keymap.set('n', '<leader>rn', function()
          local current_buf = vim.api.nvim_get_current_buf()
          local is_angularls_attached = #(vim.lsp.get_active_clients({ name = 'angularls', bufnr = current_buf })) > 0
          local is_vtsls_attached = #(vim.lsp.get_active_clients({ name = 'vtsls', bufnr = current_buf })) > 0

          if is_angularls_attached and is_vtsls_attached then
            vim.lsp.buf.rename(nil, { name = 'angularls' })
            return
          end
          vim.lsp.buf.rename()
        end)

        if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          vim.keymap.set('n', 'th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end)
        end
      end,
    })
  end,
}
