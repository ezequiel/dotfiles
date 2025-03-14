return {
  "saghen/blink.cmp",
  event = "InsertEnter",
  version = "*",
  opts = {
    enabled = function()
      -- print(vim.bo.filetype)
      -- print(vim.bo.buftype)
      return vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
        and vim.bo.filetype ~= "grug-far"
        and vim.bo.filetype ~= "qf"
        and not string.match(vim.bo.filetype, "^Avante")
    end,
    keymap = {
      preset = "super-tab",
      ["<CR>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
    },
    completion = {
      documentation = {
        window = { border = "single" },
        auto_show = true,
        treesitter_highlighting = true,
      },
      ghost_text = { enabled = true },
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
