return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    settings = {
      save_on_toggle = true,
      sync_on_ui_close = true,
    },
  },
  config = function(_, opts)
    require('harpoon'):setup()
  end,
  keys = {
    {
      '<leader>aa',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'harpoon add file',
    },
    {
      '<leader>rr',
      function()
        require('harpoon'):list():remove()
      end,
      desc = 'harpoon add file',
    },
    {
      '<C-e>',
      function()
        local harpoon = require('harpoon')
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = 'harpoon quick menu',
    },
    {
      '<Leader>11',
      function()
        require('harpoon'):list():select(1)
      end,
      desc = 'Harpoon Select File 1',
    },
    {
      '<Leader>22',
      function()
        require('harpoon'):list():select(2)
      end,
      desc = 'Harpoon Select File 2',
    },
    {
      '<Leader>33',
      function()
        require('harpoon'):list():select(3)
      end,
      desc = 'Harpoon Select File 3',
    },
    {
      '<Leader>44',
      function()
        require('harpoon'):list():select(4)
      end,
      desc = 'Harpoon Select File 4',
    },
  },
  -- init = function()
  -- local harpoon = require('harpoon')

  -- vim.api.nvim_create_autocmd('BufEnter', {
  --   callback = function()
  --     local bufname = vim.fn.expand('%')
  --     if bufname ~= '' and vim.fn.filereadable(bufname) == 1 then
  --       harpoon:list():add()
  --     end
  --   end,
  -- })

  -- vim.keymap.set('n', '<C-e>', function()
  --   harpoon.ui:toggle_quick_menu(harpoon:list())
  -- end)

  -- vim.keymap.set('n', '<C-p>', function()
  --   local list = harpoon:list()
  --
  --   local current_path = vim.fn.expand('%:.')
  --   local _, current_index = list:get_by_value(current_path)
  --
  --   if current_index and current_index > 1 then
  --     list:select(current_index - 1)
  --   end
  -- end)
  --
  -- vim.keymap.set('n', '<C-n>', function()
  --   local list = harpoon:list()
  --
  --   local current_path = vim.fn.expand('%:.')
  --   local _, current_index = list:get_by_value(current_path)
  --
  --   if current_index and current_index < list:length() then
  --     list:select(current_index + 1)
  --   end
  -- end)
  --
  -- vim.api.nvim_create_autocmd('VimLeavePre', {
  --   callback = function()
  --     local list = harpoon:list()
  --
  --     for i = list:length(), 1, -1 do
  --       local item = list:get(i)
  --       list:remove(item)
  --     end
  --   end,
  -- })
  -- end,
}
