return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  init = function()
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local treesitter = require('nvim-treesitter')
        local lang = vim.treesitter.language.get_lang(args.match)
        if vim.tbl_contains(treesitter.get_installed(), lang) then
          treesitter.update(lang):await(function()
            vim.treesitter.start()
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        elseif vim.tbl_contains(treesitter.get_available(), lang) then
          treesitter.install(lang):await(function()
            vim.treesitter.start()
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end)
        end
      end,
    })
  end,
}
