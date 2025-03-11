return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  -- opts_extend = { "sources.default" },
  opts = {
    keymap = { preset = "super-tab" },
    -- opts_extend = { "sources.default" },
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
        show_documentation = true,
      },
    },
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
