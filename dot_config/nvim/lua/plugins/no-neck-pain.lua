return {
  lazy = false,
  'shortcuts/no-neck-pain.nvim',
  opts = {
    autocmds = {
      enableOnTabEnter = true,
      enableOnVimEnter = true,
      skipEnteringNoNeckPainBuffer = true,
    },
    mappings = {
      enabled = false,
    },
    buffers = {
      left = {
        enabled = true,
      },
      right = {
        enabled = false,
      },
    },
  },
}
