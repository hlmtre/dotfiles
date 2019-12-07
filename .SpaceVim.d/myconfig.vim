function! myconfig#after() abort
  autocmd FileType gitcommit,gitrebase,gitconfig set bufhidden=delete
  set timeoutlen=100
  let g:gitgutter_max_signs=2000 " bah performance be damned, show me my git status
endfunction
