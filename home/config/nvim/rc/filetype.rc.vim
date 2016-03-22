
"---------------------------------------------------------------------------
" FileType:
"

" Enable smart indent.
set autoindent smartindent

augroup MyAutoGroup
  autocmd FileType,Syntax,BufEnter,BufWinEnter * call s:my_on_filetype()

  " Auto reload VimScript.
  autocmd BufWritePost,FileWritePost *.vim nested
        \ if &l:autoread > 0 | source <afile> |
        \   echo 'source ' . bufname('%') |
        \ endif

  " Reload .vimrc automatically.
  autocmd BufWritePost .vimrc,vimrc,*.rc.vim,*.toml nested
        \ | source $MYVIMRC | redraw

  autocmd FileType gitcommit,qfreplace setlocal nofoldenable

  autocmd FileType python setlocal foldmethod=indent

  " Update filetype.
  autocmd BufWritePost * nested
  \ if &l:filetype ==# '' || exists('b:ftdetect')
  \ |   unlet! b:ftdetect
  \ |   filetype detect
  \ | endif

  " Improved include pattern.
  autocmd FileType html
        \ setlocal includeexpr=substitute(v:fname,'^\\/','','') |
        \ setlocal path+=./;/
  autocmd FileType php setlocal path+=/usr/local/share/pear
  autocmd FileType apache setlocal path+=./;/

  autocmd FileType go highlight default link goErr WarningMsg |
        \ match goErr /\<err\>/
augroup END

augroup vimrc-highlight
  autocmd!
  autocmd Syntax * if 5000 < line('$') | syntax sync minlines=200 | endif
augroup END

" Python
let g:python_highlight_all = 1

" Vim
let g:vimsyntax_noerror = 1
"let g:vim_indent_cont = 0

" Bash
let g:is_bash = 1

" Java
let g:java_highlight_functions = 'style'
let g:java_highlight_all=1
let g:java_highlight_debug=1
let g:java_allow_cpp_keywords=1
let g:java_space_errors=1
let g:java_highlight_functions=1

" JavaScript
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Markdown
let g:markdown_fenced_languages = []

" Go
if $GOROOT != ''
   set runtimepath+=$GOROOT/misc/vim
endif

" python.vim
let python_highlight_all = 1

" http://mattn.kaoriya.net/software/vim/20140523124903.htm
let g:markdown_fenced_languages = [
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \  'vim',
      \]

function! s:my_on_filetype() abort "{{{
  " Disable automatically insert comment.
  setl formatoptions-=ro | setl formatoptions+=mMBl

  " Disable auto wrap.
  if &l:textwidth != 70 && &filetype !=# 'help'
    setlocal textwidth=0
  endif

  " Use FoldCCtext().
  if &filetype !=# 'help'
    setlocal foldtext=FoldCCtext()
  endif

  if !&l:modifiable
    setlocal nofoldenable
    setlocal foldcolumn=0
    silent! IndentLinesDisable

    if v:version >= 703
      setlocal colorcolumn=
    endif
  endif
endfunction "}}}

" Folding

" Vim script
" augroup: a
" function: f
let g:vimsyn_folding = 'af'

let g:tex_fold_enabled = 1
let g:xml_syntax_folding = 1
let g:php_folding = 1
let g:perl_fold = 1
