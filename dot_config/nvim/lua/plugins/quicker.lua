return {
  "stevearc/quicker.nvim",
  ft = "qf",
  opts = {
    opts = { wrap = true },
    wrap = true,
    borders = {
      vert = "|",
      strong_header = "-",
      strong_cross = "-",
      strong_end = "|",
      soft_header = "╌",
      soft_cross = "|",
      soft_end = "|",
    },
    trim_leading_whitespace = false,
    max_filename_width = function()
      return 24
    end,
  },
}
