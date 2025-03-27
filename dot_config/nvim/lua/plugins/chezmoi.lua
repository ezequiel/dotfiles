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
      callback = function(ev)
        local bufnr = ev.buf
        local edit_watch = function()
          require("chezmoi.commands.__edit").watch(bufnr)
        end
        vim.schedule(edit_watch)
      end,
    })
  end,
}
