if exists('g:clever_f_loaded')
    finish
endif
let g:clever_f_loaded = 1

function! clever_f#reset()
    let s:previous_char = ""

    "                    line col
    let s:previous_pos = [ 0, 0 ]
    return "\<Esc>"
endfunction

function! clever_f#find_with(map)
    if a:map !=? 'f'
        echoerr 'invalid mapping: '.a:map
        return
    endif

    let current_pos = getpos('.')[1:2]
    if current_pos != s:previous_pos
        let s:previous_char = nr2char(getchar())
    endif

    let search_flag = a:map ==# 'f' ? 'nW' : 'nbW'
    let next_pos = searchpos('\V'.s:previous_char, search_flag)

    if next_pos == [0, 0]
        call clever_f#reset()
        return "\<Esc>"
    endif

    let s:previous_pos = next_pos
    return next_pos[0].'gg0'.(next_pos[1]-1).'l'
endfunction

call clever_f#reset()
