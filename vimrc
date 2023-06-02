call plug#begin('~/.vim/vplugindir')


" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsEditSplit="tabdo"

Plug 'tpope/vim-obsession'
Plug 'lervag/vimtex'
let g:tex_flavor='lualatex'
let g:vimtex_view_method = 'zathura'
set conceallevel=0
let g:UltiSnipsEditSplit="vertical"

Plug 'derekelkins/agda-vim'
Plug 'mileszs/ack.vim'

Plug 'preservim/nerdtree'
Plug 'vim-scripts/nerdtree-ack'

Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
Plug 'whonore/Coqtail'

call plug#end()
" May need to
"   filetype off
"   syntax off

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

set mouse=nc
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
nnoremap <Leader>/ :nohl<CR>

"-Paste mode (doesn't mess with indentation and mappings within copy paste)
set pastetoggle=<F2>

"- Terminal/QoL stuff
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l
tnoremap <C-n> <C-w>N
tnoremap <C-PageDown> <C-w>:tabn<CR>
tnoremap <C-PageUp> <C-w>:tabp<CR>
tnoremap LS <C-w>:NERDTreeMirror<CR><C-w>:NERDTreeFocus<CR>
"- don't need atm. tnoremap LCS <C-w>:NERDTreeMirror<CR><C-w>:NERDTreeFind<CR><C-w>:NERDTreeFocus<CR>
tnoremap <Leader>ww <C-w>:call WindowSwap#EasyWindowSwap()<CR>
"- Might be risky? Not sure how often I use two colons in terminal...
tnoremap :: <C-w>:
"-previous command (assumes particular prompt structure)
tnoremap  ^^ <C-w>N?:) > .\\|:( > .<CR>:nohl<CR>2w
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
nnoremap LCS :NERDTreeMirror<CR>:NERDTreeFind<CR>:NERDTreeFocus<CR>
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
augroup ExtensionSpec
    autocmd!
    autocmd FileType c,cpp,h,hpp,py,java call SetMostOptions()
    autocmd FileType c,cpp,h,hpp call SetCppOptions()
    autocmd FileType tex call SetLatexOptions()
augroup END

au BufRead *.c1 set ft=

function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf
endfunction

nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
nmap <silent> <leader>pw :call DoWindowSwap()<CR>

" Sadly only Vim -> Windows clipboard.
" Not sure how to nicely do Windows -> " Vim register, but I guess I have
" ctrl+shift+v...
if system('uname -r') =~ "microsoft"
  augroup WinClipboard
  autocmd!
  autocmd TextYankPost * if v:event["regname"] == 'w' | :call system('/mnt/c/windows/system32/clip.exe ',@") | endif
  augroup END
endif

" LCD = Change to Directory of Current file
command LCD lcd %:p:h

def g:Tapi_lcd(_, path: string)
    if isdirectory(path)
        execute 'silent lcd ' .. fnameescape(path)
    endif
enddef

def g:Tapi_hvim(_, path: string)
    execute 'vsplit ' .. fnameescape(path)
enddef
def g:Tapi_jvim(_, path: string)
    execute 'split ' .. fnameescape(path)
enddef
def g:Tapi_kvim(_, path: string)
    execute 'belowright split ' .. fnameescape(path)
enddef
def g:Tapi_lvim(_, path: string)
    execute 'belowright vsplit ' .. fnameescape(path)
enddef

" Quick Beluga support
au BufRead,BufNewFile *.bel setfiletype bel

set tags=./tags;$HOME
