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
        scrollbar = false,
      },
    },
    signature = {
      enabled = true,
      window = {
        min_width = 1,
        max_width = 100,
        max_height = 10,
        border = "single",
        show_documentation = true,
        scrollbar = true,
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
