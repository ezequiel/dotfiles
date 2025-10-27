return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  init = function()
    local function is_installed(filetype)
      for lang in vim.iter(require('nvim-treesitter').get_installed()) do
        if filetype == lang then
          return true
        end
      end
      return false
    end

    local function is_available(filetype)
      for lang in vim.iter(require('nvim-treesitter').get_available()) do
        if filetype == lang then
          return true
        end
      end
      return false
    end

    vim.api.nvim_create_autocmd('FileType', {
      callback = function()
        if not is_available(vim.bo.filetype) then
          return
        end
        if not is_installed(vim.bo.filetype) then
          require('nvim-treesitter').install(vim.bo.filetype):await(function()
            vim.treesitter.start()
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        else
          vim.treesitter.start()
          vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
