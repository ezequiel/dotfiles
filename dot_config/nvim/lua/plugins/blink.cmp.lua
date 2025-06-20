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
      return vim.bo.buftype ~= 'prompt'
        and vim.b.completion ~= false
        and vim.bo.filetype ~= 'grug-far'
        and vim.bo.filetype ~= 'norg'
        and vim.bo.filetype ~= 'markdown'
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
            return true
          end
        end,
        'fallback',
      },
      ['<CR>'] = {
        function(cmp)
          return cmp.accept()
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
          return cmp.cancel()
        end,
        'fallback',
      },
    },
    completion = {
      documentation = {
        window = { border = 'single' },
        auto_show = false,
        auto_show_delay_ms = 500,
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
        border = 'single',
        auto_show = true,
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
        show_documentation = false,
        scrollbar = true,
        border = 'single',
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
