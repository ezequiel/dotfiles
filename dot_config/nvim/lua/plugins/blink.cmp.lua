local function cmp_accept_with_copilot(cmp)
  if cmp.accept() then
    return true
  end
  local copilotSuggestion = require('copilot.suggestion')
  if copilotSuggestion.is_visible() then
    copilotSuggestion.accept()
    return true
  end
end

return {
  'saghen/blink.cmp',
  dependencies = {
    'zbirenbaum/copilot.lua',
    'nvim-tree/nvim-web-devicons',
    'onsails/lspkind.nvim',
  },
  lazy = false,
  version = '*',
  opts = {
    enabled = function()
      return vim.bo.buftype ~= 'prompt'
        and vim.b.completion ~= false
        and vim.bo.filetype ~= 'grug-far'
        and vim.bo.filetype ~= 'markdown'
        and vim.bo.filetype ~= 'opencode_terminal'
    end,
    keymap = {
      preset = 'none',
      ['<C-space>'] = { 'show', 'hide' },
      ['K'] = { 'show_documentation', 'hide_documentation', 'fallback' },
      ['<C-k>'] = {},
      ['<C-e>'] = {},
      ['<C-d>'] = {},
      ['<C-u>'] = {},
      ['<C-n>'] = { 'select_next' },
      ['<C-p>'] = { 'select_prev' },
      ['<tab>'] = {
        cmp_accept_with_copilot,
        'fallback',
      },
      ['<CR>'] = {
        'accept',
        'fallback',
      },
      ['<Right>'] = {
        cmp_accept_with_copilot,
        'fallback',
      },
      ['<c-c>'] = {},
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
          auto_insert = false,
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
            label = { ellipsis = true, width = { max = 32, fill = false } },
            kind = { width = { fill = true } },
            label_description = { ellipsis = true, width = { max = 32, fill = false } },
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
    sources = {
      default = { 'lsp' },
    },
  },
  opts_extend = { 'sources.default' },
}
