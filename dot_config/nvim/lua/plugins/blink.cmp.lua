return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    keymap = { preset = "enter" },
    completion = {
      documentation = { auto_show = true, treesitter_highlighting = true },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
    },
    signature = { enabled = true, window = { show_documentation = true } },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "Nerd Font Mono",
    },
    fuzzy = { implementation = "rust" },
    sources = {
      default = { "lsp" },
    },
  },
}
