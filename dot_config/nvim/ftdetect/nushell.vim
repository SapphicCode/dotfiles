function DetectNushellShebang()
    if did_filetype()
        return
    endif

    if getline(1) =~ "[ /]nu$"
        setfiletype nu
    endif
endfunction

autocmd BufRead,BufNewFile *.nu set filetype=nu
autocmd BufRead call DetectNushellShebang()

