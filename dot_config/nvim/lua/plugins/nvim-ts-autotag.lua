return {
  "windwp/nvim-ts-autotag",
  dependencies = { "windwp/nvim-autopairs" },
  event = "InsertEnter",
  opts = {
    disable_filetype = { "snacks_picker_input", "grug-far" },
    enabled = function()
      -- print(vim.bo.buftype)
      -- print(vim.bo.filetype)
      return vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
    end,
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
