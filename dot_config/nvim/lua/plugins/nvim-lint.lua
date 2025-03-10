return {
  "mfussenegger/nvim-lint",
  -- keep this in sync with linters_by_ft
  ft = { "css", "html", "javascript", "javascriptreact", "json", "jsonc", "scss", "typescript", "typescriptreact" },
  config = function()
    vim.env.ESLINT_D_MISS = "fail"
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    vim.env.ESLINT_D_IDLE = "1337"

    local lint = require("lint")
    lint.linters_by_ft = {
      css = { "eslint_d" },
      html = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      json = { "eslint_d" },
      jsonc = { "eslint_d" },
      scss = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    local function callback()
      if not vim.opt_local.modifiable:get() then
        return
      end

      local current_dir = vim.fn.expand("%:h")

      if current_dir == "" then
        return
      end

      local linters = lint.linters_by_ft[vim.bo.filetype] or {}
      if not vim.tbl_contains(linters, "eslint_d") then
        lint.try_lint()
        return
      end

      local function find_eslint_root(dir)
        while dir do
          if vim.loop.fs_stat(dir .. "/node_modules/eslint") then
            return dir
          end
          local parent_dir = vim.fs.dirname(dir)
          if parent_dir == dir then
            break
          end
          dir = parent_dir
        end
        return nil
      end

      local eslint_root = find_eslint_root(current_dir)
      if eslint_root then
        lint.try_lint("eslint_d", { cwd = eslint_root })
      end

      lint.try_lint(vim.tbl_filter(function(linter)
        return linter ~= "eslint_d"
      end, linters))
    end

    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = callback,
    })

    callback()
  end,
}
