
-- https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
  -- "hi LspReferenceRead cterm=bold ctermbg=red guibg=DarkSlateBlue
  -- "hi LspReferenceText cterm=bold ctermbg=red guibg=#823838
  -- "hi LspReferenceWrite cterm=bold ctermbg=red guibg=MediumPurple3
-- vim.api.nvim_exec([[
-- function! MyHighlights() abort
--   highlight CursorLine    ctermbg=236 guibg=#444444 cterm=none gui=none
-- endfunction

-- augroup MyColors
--   autocmd!
--   autocmd ColorScheme tokyonight call MyHighlights()
-- augroup END
-- ]], true)


require('settings')
require('plugins')

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])
-- vim.cmd([[highlight CursorLine    ctermbg=236 guibg=#444444 cterm=none gui=none]])
--
