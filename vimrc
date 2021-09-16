call plug#begin('~/.vim/vplugindir')


" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'

Plug 'preservim/nerdtree'
Plug 'tpope/vim-obsession'
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
set conceallevel=0
let g:UltiSnipsEditSplit="vertical"

Plug 'derekelkins/agda-vim'

call plug#end()
" May need to
"   filetype off
"   syntax off

function LatexMatrix(m,...)
    let a:n = a:0 >= 1? a:1 : 1
    for row in range(a:m)
        for col in range(a:n)
            exe "norm a<++> & "
        endfor
        if row < a:m-1
            exe "norm Xi\\\\\<cr>"
        else
            exe "norm xxx"
        endif
    endfor
endfunction

function SetLatexOptions()
    set shiftwidth=2
    noremap TOC :VimtexTocToggle<CR>
endfunction

function SetCC0Options()
    set syntax off
endfunction

try
    source ~/linuxconfigs/svimrc
catch
endtry

"-xml folding
augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

function SetCppOptions()
    "-if/while/for for c++
    noremap rif iif ()<Enter>{<Enter>}<Esc>2k=2j$i
    noremap rwhile iwhile ()<Enter>{<Enter>}<Esc>2k=2j$i
    "- this guy makes for for ijk
    for i in split('ijk', '\zs')
        execute printf("noremap rfor%s i for (int %s = 0; %s < ; %s++)<Enter>{<Enter>}<Esc>2k=2j$5hi", i, i, i, i)
    endfor
    "- general for
    nnoremap rforg i for ()<Enter>{<Enter>}<Esc>2k=2j$i
    nnoremap ; A;<Esc>
    nnoremap #i< i#include <><Esc>i
    nnoremap #i" i#include ""<Esc>i

    "- cindent overrides smartindent
    set cindent
    set cinoptions=(:N0,g0,0,u0,U0,w1
endfunction

function SetMostOptions()
    "-auto closing for most languages (not <> because << and >> )
    inoremap () ()<Left>
    inoremap {} {<Enter>}<Esc>k$i<Right>
    inoremap "" ""<Left>
    inoremap '' ''<Left>
    inoremap [] []<Left>


    "-wrap selection in quotes, parenthesis, or {} brackets w/ indent
    vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
    vnoremap " <ESC>`>a"<ESC>`<i"<ESC>
    vnoremap { <ESC>`>a<Enter>}<ESC>`<i{<Enter><ESC>`<=i{
endfunction


" Make the dot command work as expected in visual mode
vnoremap . :norm.<CR>")"

filetype plugin on
filetype indent on

syntax on

set mouse=n
set title

set background=dark

"-Indent
set autoindent
set smartindent
set shiftwidth=4

set expandtab

"-Key changes
set backspace=indent,eol,start


"-Search
set ignorecase
set smartcase
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>

"-Paste mode (doesn't mess with indentation and mappings within copy paste)
set pastetoggle=<F2>

"-vertical terminal short
com! Vterm :vert term

"-Center screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

"- gc - swap char with next
nnoremap <silent> gc xph
"- gw - swap word with next
nnoremap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
"- gh, gl swap word left/right and move cursor to new location
nnoremap <silent> gh "_yiw?\w\+\_W\+\%#<CR>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o><c-l>:nohlsearch<CR>
nnoremap <silent> gl "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR><c-o>/\w\+\_W\+<CR><c-l>:nohlsearch<CR>
"- g{ - swap paragraph with next
nnoremap g{ {dap}p{
"- alt + j, move current line down 1, alt + k, move current line up 1 (also works with visual mode)
nnoremap gj :m .+1<CR>==
nnoremap gk :m .-2<CR>==
vnoremap gj :m '>+1<CR>gv=gv
vnoremap gk :m '<-2<CR>gv=gv

nnoremap LS :NERDTreeMirror<CR>:NERDTreeFocus<CR>
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"- gf on new tab
nnoremap gf <C-w>gf

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! Diff call s:DiffWithSaved()


set number
set relativenumber
set encoding=utf-8
autocmd FileType c,cpp,h,hpp,py,java call SetMostOptions()
autocmd FileType c,cpp,h,hpp call SetCppOptions()
autocmd FileType tex call SetLatexOptions()

au BufRead *.c1 set ft=

