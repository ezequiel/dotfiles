return {
  'saghen/blink.cmp',
  dependencies = {
    'zbirenbaum/copilot.lua',
    'nvim-tree/nvim-web-devicons',
    'onsails/lspkind.nvim',
  },
  event = 'InsertEnter',
  version = '*',
  opts = {
    enabled = function()
      -- print(vim.bo.filetype)
      -- print(vim.bo.buftype)
      return vim.bo.buftype ~= 'prompt'
        and vim.b.completion ~= false
        and vim.bo.filetype ~= 'grug-far'
        and vim.bo.filetype ~= 'norg'
        and vim.bo.filetype ~= 'copilot-chat'
      -- and vim.bo.filetype ~= "qf"
    end,
    keymap = {
      preset = 'super-tab',
      ['<C-space>'] = { 'show', 'hide' },
      ['K'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-d>'] = { 'select_next' },
      ['<C-u>'] = { 'select_prev' },
      ['<C-e>'] = {},
      ['<tab>'] = {
        function(cmp)
          if cmp.accept() then
            return true
          end
          local copilotSuggestion = require('copilot.suggestion')
          if copilotSuggestion.is_visible() then
            copilotSuggestion.accept()
            vim.schedule(function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
            end)
            return true
          end
        end,
        'fallback',
      },
      ['<CR>'] = {
        function(cmp)
          if cmp.accept() then
            vim.schedule(function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
            end)
            return true
          end
        end,
        'fallback',
      },
      ['<Right>'] = {
        function(cmp)
          return cmp.accept()
        end,
        'fallback',
      },
      ['<c-c>'] = {
        function(cmp)
          cmp.cancel()
          vim.schedule(function()
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'n', true)
          end)
        end,
        'fallback',
      },
    },
    completion = {
      documentation = {
        auto_show = false,
        auto_show_delay_ms = 500,
        window = {
          border = 'single',
        },
      },
      list = {
        cycle = { from_top = false, from_bottom = false },
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = { enabled = false },
      menu = {
        auto_show = true,
        border = 'single',
        draw = {
          treesitter = { 'lsp' },
          columns = {
            { 'label' },
            { 'kind_icon', 'kind', 'label_description', gap = 1 },
          },
          components = {
            label = { ellipsis = true, width = { max = 16, fill = false } },
            kind = { width = { fill = true } },
            label_description = { ellipsis = true, width = { max = 16, fill = false } },
            kind_icon = {
              width = { fill = false },
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, _ = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    icon = dev_icon
                  end
                else
                  icon = require('lspkind').symbolic(ctx.kind, {
                    mode = 'symbol',
                  })
                end

                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ 'Path' }, ctx.source_name) then
                  local dev_icon, dev_hl = require('nvim-web-devicons').get_icon(ctx.label)
                  if dev_icon then
                    hl = dev_hl
                  end
                end
                return hl
              end,
            },
          },
        },
        scrollbar = false,
      },
      accept = { auto_brackets = { enabled = false } },
    },
    signature = {
      enabled = true,
      window = {
        border = 'single',
        show_documentation = false,
        scrollbar = true,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = 'mono',
    },
    fuzzy = { implementation = 'rust' },
    sources = {
      providers = {
        lsp = {
          async = true,
        },
      },
      default = { 'lsp', 'buffer' },
    },
  },
  opts_extend = { 'sources.default' },
}
