vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'
vim.deprecate = function() end
require('config.opt')
require('config.keymap')
require('config.cmd')
require('config.random')
require('config.lazy')
