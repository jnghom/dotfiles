require('main')
require('plugins')

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
