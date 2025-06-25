return {
  'windwp/nvim-ts-autotag',
  event = 'InsertEnter',
  opts = {
    disable_filetype = { 'snacks_picker_input', 'grug-far' },
    enabled = function()
      return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
    end,
  },
  config = true,
}
