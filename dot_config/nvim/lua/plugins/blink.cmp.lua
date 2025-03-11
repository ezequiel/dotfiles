return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  -- opts_extend = { "sources.default" },
  opts = {
    keymap = { preset = "enter" },
    -- opts_extend = { "sources.default" },
    completion = {
      documentation = { auto_show = true, treesitter_highlighting = true },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
      menu = {
        draw = {
          columns = {
            -- kind, source_id, source_name, kind_icon, label, label_description
            { "kind_icon", "label", "label_description", gap = 1 },
          },
        },
      },
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
