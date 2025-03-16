return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  opts = {},
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)
  end,
}
