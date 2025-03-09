return {
  "saecki/live-rename.nvim",
  keys = {
    {
      "<leader>r",
      function()
        require("live-rename").rename({ insert = true })
      end,
    },
  },
}
