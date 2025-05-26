return {
  'RRethy/vim-illuminate',
  event = 'VeryLazy',
  config = function()
    require('illuminate').configure({
      providers = {
        'lsp',
        'treesitter',
      },
      under_cursor = false,
      delay = 350,
      disable_keymaps = true,
    })
  end,
}
