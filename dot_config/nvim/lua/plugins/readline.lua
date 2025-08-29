return {
  'assistcontrol/readline.nvim',
  lazy = false,
  keys = {
    {
      '<M-b>',
      mode = '!',
      function()
        require('readline').backward_word()
      end,
    },
    {
      '<M-f>',
      mode = '!',
      function()
        require('readline').forward_word()
      end,
    },
    {
      '<M-BS>',
      mode = '!',
      function()
        require('readline').backward_kill_word()
      end,
    },
    {
      '<C-w>',
      mode = '!',
      function()
        require('readline').unix_word_rubout()
      end,
    },
    {
      '<C-e>',
      mode = {
        '!',
        'i',
        'n',
        'x',
      },
      function()
        require('readline').end_of_line()
      end,
    },
    {
      '<C-u>',
      mode = '!',
      function()
        require('readline').dwim_backward_kill_line()
      end,
    },
    {
      '<C-k>',
      mode = '!',
      function()
        require('readline').kill_line()
      end,
    },
    {
      '<C-a>',
      mode = {
        '!',
        'i',
        'n',
        'x',
      },
      function()
        require('readline').dwim_beginning_of_line()
      end,
      { noremap = true },
    },
  },
}
