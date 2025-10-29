vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

vim.cmd([[
  let g:did_install_default_menus = 1
  let g:did_install_syntax_menu = 1
  let g:loaded_editorconfig = 1
  let g:loaded_gzip = 1
  let g:loaded_man = 1
  let g:loaded_matchit = 1
  let g:loaded_net = 1
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

if vim.version().minor >= 12 then
  require('vim._extui').enable({
    enable = true,
    msg = {
      target = 'cmd',
      timeout = 2500,
    },
  })
end

require('config.opt')
require('config.keymap')
require('config.cmd')
require('config.random')
require('config.lazy')
