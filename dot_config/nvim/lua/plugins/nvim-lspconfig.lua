return {
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    'WhoIsSethDaniel/mason-tool-installer',
    'mason-org/mason.nvim',
    {
      'luckasRanarison/tailwind-tools.nvim',
      ft = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
      },
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
        'angular-language-server',
        'docker-compose-language-service',
        'dockerfile-language-server',
        'eslint-lsp',
        'goimports',
        'golangci-lint-langserver',
        'gopls',
        'html-lsp',
        'json-lsp',
        'lua-language-server',
        'marksman',
        'shfmt',
        'stylua',
        'tailwindcss-language-server',
        'vtsls',
        'yaml-language-server',
        'yamlfmt',
      },
      auto_update = true,
    })
    require('mason').setup()

    local lsp_opts = {
      gopls = {},
      yamlls = {},
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
      angularls = {
        workspace_required = true,
      },
      marksman = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            diagnostics = {
              globals = { 'vim', 'Snacks' },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file('lua', true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      docker_compose_language_service = {},
      dockerls = {},
      jsonls = { init_options = { provideFormatter = false } },
      html = { init_options = { provideFormatter = false } },
      eslint = {
        filetypes = {
          'html',
          'htmlangular',
          'javascript',
          'javascriptreact',
          'json',
          'jsonc',
          'typescript',
          'typescriptreact',
        },
        settings = {
          experimental = {
            useFlatConfig = true,
          },
          workingDirectory = {
            mode = 'auto',
          },
        },
      },
      tailwindcss = {},
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

    for name, opts in pairs(lsp_opts) do
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
  init = function()
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'K', function()
      vim.lsp.buf.hover({
        focusable = true,
        silent = true,
        wrap = false,
        border = 'single',
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
      end,
    })
  end,
}
