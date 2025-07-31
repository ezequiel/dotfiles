return {
  'windwp/nvim-ts-autotag',
  lazy = false,
  opts = {
    disable_filetype = { 'snacks_picker_input', 'grug-far', 'AvanteInput' },
    enabled = function()
      return vim.bo.buftype ~= 'prompt' and vim.b.completion ~= false
    end,
  },
  config = true,
}
