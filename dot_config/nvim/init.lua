vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.deprecate = function() end

vim.cmd([[
  let g:did_install_default_menus = 1
  let g:did_install_syntax_menu = 1
  let g:loaded_editorconfig = 1
  let g:loaded_gzip = 1
  let g:loaded_man = 1
  let g:loaded_matchit = 1
  let g:loaded_matchparen = 1
  let g:loaded_netrwPlugin = 1
  let g:loaded_osc52 = 1
  let g:loaded_rplugin = 1
  let g:loaded_shada = 1
  let g:loaded_spellfile = 1
  let g:loaded_tarPlugin = 1
  let g:loaded_tohtml = 1
  let g:loaded_tutor = 1
  let g:loaded_zipPlugin = 1
]])

require('config.opt')
require('config.keymap')
require('config.cmd')
require('config.random')
require('config.lazy')
