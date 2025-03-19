return {
  "folke/noice.nvim",
  opts = {
    lsp = {
      hover = {
        silent = true,
      },
      signature = {
        enabled = false,
      },
    },
    presets = {
      lsp_doc_border = true,
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
}
