return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  opts = {
    sign_priority = 1337,
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map('n', ']h', function()
        gitsigns.nav_hunk('next')
      end)

      map('n', '[h', function()
        gitsigns.nav_hunk('prev')
      end)

      -- Actions
      map('n', '<leader>hs', gitsigns.stage_hunk)
      map('n', '<leader>hr', gitsigns.reset_hunk)

      map('v', '<leader>hs', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      map('v', '<leader>hr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end)

      map('n', '<leader>hS', gitsigns.stage_buffer)
      map('n', '<leader>hR', gitsigns.reset_buffer)
      map('n', '<leader>hp', gitsigns.preview_hunk)

      map('n', '<leader>hb', function()
        gitsigns.blame_line({ full = true })
      end)

      map('n', '<leader>hd', gitsigns.diffthis)

      map('n', '<leader>hQ', function()
        gitsigns.setqflist('all')
      end)
      map('n', '<leader>hq', gitsigns.setqflist)

      -- Text object
      map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
    end,
  },
}
