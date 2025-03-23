return {
  lazy = false,
  "shortcuts/no-neck-pain.nvim",
  opts = {
    buffers = {
      scratchPad = {
        enabled = true,
        pathToFile = "~/Desktop/vim-notes__" .. os.date("%m-%d-%Y") .. ".txt",
      },
      left = {
        enabled = true,
      },
      right = {
        enabled = false,
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "VimEnter" }, {
      pattern = "*",
      once = true,
      callback = function()
        require("no-neck-pain.main").enable("")
      end,
    })
  end,
}
