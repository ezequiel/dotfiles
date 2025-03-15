return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  opts = {
    enabled = function()
      -- print(vim.bo.filetype)
      -- print(vim.bo.buftype)
      return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false and vim.bo.filetype ~= "grug-far"
    end,
  },
}
