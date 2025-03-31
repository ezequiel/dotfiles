return {
  "saghen/blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  event = "InsertEnter",
  version = "*",
  opts = {
    enabled = function()
      -- print(vim.bo.filetype)
      -- print(vim.bo.buftype)
      return vim.bo.buftype ~= "prompt"
        and vim.b.completion ~= false
        and vim.bo.filetype ~= "grug-far"
        and vim.bo.filetype ~= "norg"
        -- and vim.bo.filetype ~= "qf"
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
      ["<Right>"] = {
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
      ["<c-c>"] = {
        function(cmp)
          if cmp.cancel() then
            vim.schedule(function()
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
            end)
            return true
          end
        end,
      },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
          auto_insert = false,
        },
      },
      ghost_text = { enabled = true },
      menu = {
        auto_show = true,
        border = "single",
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
          },
        },
        scrollbar = false,
      },
      accept = { auto_brackets = { enabled = true } },
    },
    signature = {
      enabled = true,
      window = {
        border = "single",
        show_documentation = false,
        scrollbar = true,
      },
    },
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },
    fuzzy = { implementation = "rust" },
    sources = {
      default = { "lsp", "buffer", "copilot" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
  },
  opts_extend = { "sources.default" },
}
