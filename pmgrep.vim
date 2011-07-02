" pmgrep.vim
"
" Author: Tsuyoshi Torii
" Description:
"   How to Use
"     :Pmgrep <search-string> <module-name>
"     :PmgrepInc <search-string>
"     :PmgrepProject <search-string>
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

function! s:PmgrepInc(...)
  let args = ['pm-grep', '--quickfix', '--project', '--inc']
  let args += len(a:000) ? a:000 : [expand('<cword>')]

  cgetexpr system(join(args, ' '))
  echo join(args, ' ')
  silent exec 'cwin'
endfunction

function! s:PmgrepProject(...)
  let args = ['pm-grep', '--quickfix', '--project']
  let args += len(a:000) ? a:000 : [expand('<cword>')]

  cgetexpr system(join(args, ' '))
  echo join(args, ' ')
  silent exec 'cwin'
endfunction

function! GetVisualText()
  let tmp = @@
  silent normal gvy
  let selected = @@
  let @@ = tmp
  return selected
endfunction

function! s:PmgrepProjectVS()
  let selected = GetVisualText()
  call ExecutePmgrepProject(selected)
endfunction

function! s:PmgrepProjectVSSub()
  let selected = GetVisualText()
  let selected = '''sub ' . selected . ''''
  call ExecutePmgrepProject(selected)
endfunction

function! ExecutePmgrepProject(text)
  let args = ['pm-grep', '--quickfix', '--project']
  let args += [a:text]

  cgetexpr system(join(args, ' '))
  echo join(args, ' ')
  silent exec 'cwin'
endfunction

command! -nargs=* Pmgrep :call s:Pmgrep(<f-args>)
command! -nargs=* PmgrepInc :call s:PmgrepInc(<f-args>)
command! -nargs=* PmgrepProject :call s:PmgrepProject(<f-args>)
command! -range PmgrepProjectVS :call s:PmgrepProjectVS()
command! -range PmgrepProjectVSSub :call s:PmgrepProjectVSSub()

