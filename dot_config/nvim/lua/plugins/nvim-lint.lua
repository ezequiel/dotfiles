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
        local linters = lint.linters_by_ft[vim.bo.filetype] or {}

        if vim.tbl_contains(linters, "eslint_d") then
          local current_file = vim.api.nvim_buf_get_name(0)
          if current_file == "" then
            return
          end

          local function find_eslint_root(start_path)
            local uv = vim.loop
            local current_dir = start_path

            while current_dir do
              local eslint_path = current_dir .. "/node_modules/eslint"
              if uv.fs_stat(eslint_path) then
                return current_dir
              end

              local parent_dir = uv.fs_realpath(current_dir .. "/..")
              if parent_dir == current_dir then
                break
              end
              current_dir = parent_dir
            end

            return nil
          end

          local eslint_root = find_eslint_root(vim.fn.fnamemodify(current_file, ":h"))
          if eslint_root then
            lint.try_lint("eslint_d", { cwd = eslint_root })
            return
          end
        end

        lint.try_lint()
      end,
    })
  end,
}
