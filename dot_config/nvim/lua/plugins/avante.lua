return {
  'yetone/avante.nvim',
  lazy = false,
  build = 'make',
  version = false,
  opts = {
    provider = 'copilot',
    windows = {
      edit = {
        border = 'single',
      },
      ask = {
        floating = false,
        border = 'single',
      },
    },
    hints = { enabled = false },
    selector = {
      provider = 'snacks',
      provider_opts = {},
    },
    mappings = {
      diff = {
        ours = '<leader>cc',
        theirs = '<leader>ic',
        both = '<leader>bc',
        all_theirs = nil,
        cursor = nil,
        next = ']c',
        prev = '[c',
      },
      suggestion = {
        accept = nil,
        next = nil,
        prev = nil,
        dismiss = nil,
      },
      jump = {
        next = nil,
        prev = nil,
      },
      submit = {
        normal = '<CR>',
        insert = '<C-s>',
      },
      cancel = {
        normal = { '<C-c>', '<Esc>', 'q' },
        insert = { '<C-c>' },
      },
      sidebar = {
        apply_all = nil,
        apply_cursor = nil,
        retry_user_request = nil,
        edit_user_request = nil,
        switch_windows = nil,
        reverse_switch_windows = nil,
        remove_file = 'd',
        add_file = 'a',
        close = { '<C-c>', 'q' },
        close_from_input = { normal = '<C-c>', insert = '<C-c>' },
      },
    },
  },
  keys = {
    {
      '<leader>ae',
      function()
        vim.cmd('AvanteStop')
        vim.cmd('AvanteEdit')
      end,
      mode = { 'x' },
    },
    { '<leader>at', '<cmd>AvanteToggle<cr>' },
  },
  dependencies = {
    'zbirenbaum/copilot.lua',
    'MunifTanjim/nui.nvim',
    'folke/snacks.nvim',
    -- 'nvim-lua/plenary.nvim',
    -- 'nvim-tree/nvim-web-devicons',
    -- {
    --   'MeanderingProgrammer/render-markdown.nvim',
    --   opts = {
    --     file_types = { 'markdown', 'Avante' },
    --   },
    --   ft = { 'markdown', 'Avante' },
    -- },
  },
}
