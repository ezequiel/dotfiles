return {
  'neovim/nvim-lspconfig',
  lazy = false,
  config = function()
    local lsp_opts = {
      angularls = {
        workspace_required = true,
      },
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
      docker_compose_language_service = {},
      dockerls = {},
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
      gopls = {},
      html = {},
      jsonls = {},
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              enable = true,
            },
            diagnostics = {
              enable = true,
              globals = { 'vim', 'Snacks' },
            },
            format = {
              enable = false,
            },
            runtime = {
              version = 'LuaJIT',
            },
            telemetry = { enable = false },
            workspace = {
              library = { vim.fs.joinpath(vim.env.VIMRUNTIME, '/lua') },
              checkThirdParty = false,
            },
          },
        },
      },
      marksman = {},
      vtsls = {
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
          },
          typescript = {
            tsserver = {
              experimental = {
                -- NOTE: Some projects will crawl to a halt when this is enabled
                -- enableProjectDiagnostics = true,
              },
            },
            preferences = {
              importModuleSpecifier = 'non-relative',
            },
          },
        },
      },
      yamlls = {},
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
        local vtslsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'vtsls' })
        local angularLsClients = vim.lsp.get_clients({ bufnr = event.buf, name = 'angularls' })
        if #vtslsClients > 0 and #angularLsClients > 0 then
          vtslsClients[1].server_capabilities.referencesProvider = false
        end

        vim.keymap.set('n', '<leader>rn', function()
          local current_buf = vim.api.nvim_get_current_buf()
          local vtslsClients = vim.lsp.get_clients({ bufnr = current_buf, name = 'vtsls' })
          local angularLsClients = vim.lsp.get_clients({ bufnr = current_buf, name = 'angularls' })
          if #vtslsClients > 0 and #angularLsClients > 0 then
            vim.lsp.buf.rename(nil, { name = 'angularls' })
            return
          end
          vim.lsp.buf.rename()
        end)
      end,
    })
  end,
}
