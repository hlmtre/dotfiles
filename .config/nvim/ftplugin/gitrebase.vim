function RebaseActionToggle(key)
    let line = getline(".")
    let result = matchstr(line, "^\\a")
    let transitions = {'p': 'pick', 's': 'squash', 'e': 'edit', 'f': 'fixup'}
    execute "normal! ^cw" . transitions[a:key]
endfunction

noremap <buffer> p :call RebaseActionToggle('p')<Cr>
noremap <buffer> s :call RebaseActionToggle('s')<Cr>
noremap <buffer> e :call RebaseActionToggle('e')<Cr>
noremap <buffer> f :call RebaseActionToggle('f')<Cr>
