local M = {}

function M.setup_fzf_vim()
      vim.api.nvim_exec(
      [[
      nnoremap <silent> <space><space> :Files<CR>
      nnoremap <silent> <space>g       :GFiles<CR>
      nnoremap <silent> <space>a       :Buffers<CR>
      nnoremap <silent> <space>A       :Windows<CR>
      nnoremap <silent> <space>;       :Lines<CR>
      nnoremap <silent> <space>.       :BLines<CR>
      nnoremap <silent> <space>T       :Tags<CR>
      nnoremap <silent> <space>t       :BTags<CR>
      nnoremap <silent> <space>h       :History<CR>
      nnoremap <silent> <space>h/      :History/<CR>
      nnoremap <silent> <space>h:      :History:<CR>
      nnoremap <silent> <space>/       :Rg<CR>
      nnoremap <silent> <space>//      :execute 'GGrep ' . input('GGrep/')<CR>
      nnoremap <silent> **             :call SearchWordWithRgW()<CR>
      vnoremap <silent> **             :call SearchVisualSelectionWithRg()<CR>
      nnoremap <silent> <space>C       :Commits<CR>
      nnoremap <silent> <space>c       :BCommits<CR>
      nnoremap <silent> <space>m       :FZFMru<CR>
      nnoremap <silent> <space>M       :Marks<CR>
      nnoremap <silent> <space>?       :Helptags<CR>

      " Mapping selecting mappings
      nmap <leader><tab> <plug>(fzf-maps-n)
      xmap <leader><tab> <plug>(fzf-maps-x)
      omap <leader><tab> <plug>(fzf-maps-o)

      " Insert mode completion
      imap <c-x><c-k> <plug>(fzf-complete-word)
      imap <c-x><c-f> <plug>(fzf-complete-path)
      imap <c-x><c-l> <plug>(fzf-complete-line)

      command! -bang -nargs=* GGrep call fzf#vim#grep( 'git grep --line-number -- '.shellescape(<q-args>), 0, fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
      command! -bang -nargs=* Rgw call fzf#vim#grep( 'rg -w --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1, <bang>0 ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)

      function! SearchWordWithRgW()
        execute 'Rgw' expand('<cword>')
      endfunction

      function! SearchVisualSelectionWithRg() range
        let old_reg = getreg('"')
        let old_regtype = getregtype('"')
        let old_clipboard = &clipboard
        set clipboard&
        normal! ""gvy
        let selection = getreg('"')
        call setreg('"', old_reg, old_regtype)
        let &clipboard = old_clipboard
        execute 'Rg' selection
      endfunction

      ]],
      true)
end

function M.setup_fzf_lua()
      vim.api.nvim_exec(
      [[
      nnoremap <silent> <c-p> :FzfLua files<CR>
      nnoremap <silent> <space>g       :FzfLua git_files<CR>

      nnoremap <silent> <space><space> :FzfLua builtin<CR>
      nnoremap <silent> <space>b       :FzfLua blines<CR>
      nnoremap <silent> <space>m       :FzfLua marks<CR>

      nnoremap <silent> <space>/       :FzfLua grep_project<CR>
      nnoremap <silent> <space>w       :FzfLua grep_cword<CR>

      nnoremap <silent> <space>c       :FzfLua commands<CR>

      nnoremap <silent> <space>j       :FzfLua jumps<CR>
      nnoremap <silent> <space>hf      :FzfLua oldfiles<CR>
      nnoremap <silent> <space>hc      :FzfLua command_history<CR>
      nnoremap <silent> <space>hs      :FzfLua search_history<CR>
      ]],
      true)
end

function M.setup_telescope_old()
      vim.cmd [[
      " Find files using Telescope command-line sugar.
      nnoremap <leader>ff  <cmd>Telescope find_files<cr>
      nnoremap <leader>fg  <cmd>Telescope live_grep<cr>
      nnoremap <leader>fb  <cmd>Telescope buffers<cr>
      nnoremap <leader>fh  <cmd>Telescope help_tags<cr>
      nnoremap <leader>fds <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <leader>fws <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <leader>fca <cmd>Telescope lsp_code_actions<cr>
      nnoremap <leader>fdi <cmd>Telescope diagnostics<cr>
      ]]
end

function M.setup_telescope()
      vim.cmd [[
      " Find files using Telescope command-line sugar.
      nnoremap <space>f  <cmd>Telescope find_files<cr>
      nnoremap <space>/  <cmd>Telescope live_grep<cr>
      nnoremap <space>g  <cmd>Telescope git_files<cr>
      nnoremap <space>.  <cmd>Telescope grep_string<cr>
      nnoremap <space>b  <cmd>Telescope buffers<cr>
      nnoremap <space>m  <cmd>Telescope marks<cr>

      nnoremap <space><space>/  <cmd>Telescope search_history<cr>

      nnoremap <space>p  <cmd>Telescope commands<cr>
      nnoremap <space><space>p  <cmd>Telescope command_history<cr>

      nnoremap <space>vj  <cmd>Telescope jumplist<cr>
      nnoremap <space>vk  <cmd>Telescope keymaps<cr>

      nnoremap <space>h  <cmd>Telescope help_tags<cr>

      nnoremap <space>d  <cmd>Telescope lsp_definitions<cr>
      nnoremap <space>D  <cmd>Telescope lsp_type_definitions<cr>
      nnoremap <space>s  <cmd>Telescope lsp_document_symbols<cr>
      nnoremap <space>S  <cmd>Telescope lsp_workspace_symbols<cr>
      nnoremap <space>a  <cmd>Telescope lsp_code_actions<cr>
      nnoremap <space>l  <cmd>Telescope diagnostics bufnr=0<cr>
      nnoremap <space>L  <cmd>Telescope diagnostics<cr>
      nnoremap <space>i  <cmd>Telescope lsp_implementations<cr>

      nnoremap <space>c  <cmd>Telescope git_bcommits<cr>
      nnoremap <space>C  <cmd>Telescope git_commits<cr>
      nnoremap <space>x  <cmd>Telescope git_status<cr>

      nnoremap <space><space>  <cmd>Telescope builtin<cr>
      ]]
end

function M.setup()
  M.setup_fzf_vim()
  M.setup_fzf_lua()
  M.space()
end

return M
