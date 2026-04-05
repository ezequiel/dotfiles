vim.pack.add({
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('gitsigns').setup({
  sign_priority = 0,
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 0,
    virt_text_priority = 2,
  },
  update_debounce = 1000,
  on_attach = function(bufnr)
    local gitsigns = require('gitsigns')

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map('n', ']h', function()
      if vim.wo.diff then
        vim.cmd.normal({ ']c', bang = true })
      else
        gitsigns.nav_hunk('next', { target = 'all' })
      end
    end)

    map('n', '[h', function()
      if vim.wo.diff then
        vim.cmd.normal({ '[c', bang = true })
      else
        gitsigns.nav_hunk('prev', { target = 'all' })
      end
    end)

    map('n', '<leader>hs', gitsigns.stage_hunk)

    map('n', '<leader>hr', gitsigns.reset_hunk)

    map('x', '<leader>hs', function()
      gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('x', '<leader>hr', function()
      gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
    end)

    map('n', '<leader>hS', gitsigns.stage_buffer)

    map('n', '<leader>hR', gitsigns.reset_buffer)

    map('n', '<leader>hp', gitsigns.preview_hunk)

    map('n', '<leader>hb', function()
      gitsigns.blame_line({ full = true })
    end)

    map('n', '<leader>hQ', function()
      gitsigns.setqflist('all')
    end)

    map('n', '<leader>hq', gitsigns.setqflist)
  end,
})
