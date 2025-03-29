return {
  event = "VeryLazy",
  "xvzc/chezmoi.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    edit = {
      watch = true,
    },
  },
  init = function()
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = {
        (vim.fn.expand("~")):gsub("\\", "/") .. "/.local/share/chezmoi/*",
      },
      callback = function(event)
        vim.schedule(function()
          require("chezmoi.commands.__edit").watch(event.buf)
        end)
      end,
    })
  end,
}
