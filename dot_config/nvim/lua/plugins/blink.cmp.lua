return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    keymap = { preset = "super-tab" },
    completion = {
      documentation = {
        window = { border = "single" },
        auto_show = true,
        treesitter_highlighting = true,
      },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
      menu = {
        border = "single",
        draw = {
          treesitter = { "lsp" },
          columns = {
            -- kind, source_id, source_name, kind_icon, label, label_description
            { "kind_icon", "label", "label_description", gap = 1 },
          },
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = "single",
        show_documentation = false,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    fuzzy = { implementation = "rust" },
    sources = {
      default = { "lsp", "buffer" },
    },
  },
  opts_extend = { "sources.default" },
}
