return {
  "mfussenegger/nvim-lint",
  event = "BufReadPre",
  config = function()
    vim.env.ESLINT_D_MISS = "fail"
    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    vim.env.ESLINT_D_IDLE = "1337"

    require("lint").linters_by_ft = {
      css = { "eslint_d" },
      html = { "eslint_d" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      json = { "eslint_d" },
      jsonc = { "eslint_d" },
      scss = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
      callback = function()
        local lint = require("lint")
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
          local uv = vim.loop
          while dir do
            local eslint_path = dir .. "/node_modules/eslint"
            if uv.fs_stat(eslint_path) then
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
      end,
    })
  end,
}
