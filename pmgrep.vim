" pmgrep.vim
"
" Author: Tsuyoshi Torii
" Description:
"   How to Use
"     :Pmgrep <search-string> <module-name>
"

if exists("g:loaded_pmgrep")
  finish
endif
let g:loaded_pmgrep = 1

function! s:Pmgrep(...)
  let args = ['pm-grep', '--quickfix']
  let args += len(a:000) ? a:000 : [expand('<cword>')]

  cgetexpr system(join(args, ' '))
  silent exec 'cwin'
endfunction

command! -nargs=* -complete=file Pmgrep :call s:Pmgrep(<f-args>)
