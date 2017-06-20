"-if/while/for for c++
autocmd FileType c,cpp,h,hpp noremap rif iif ()<Enter>{<Enter>}<Esc>2k=2j$i
autocmd FileType c,cpp,h,hpp noremap rwhile iwhile ()<Enter>{<Enter>}<Esc>2k=2j$i
"- this guy makes for templates from a to z
for i in split('abcdefghijklmnopqrstuvwxyz', '\zs')
    execute printf("autocmd FileType c,cpp,h,hpp noremap rfor%s i for (int %s = 0; %s < ; %s++)<Enter>{<Enter>}<Esc>2k=2j$5hi", i, i, i, i)
endfor
autocmd FileType c,cpp,h,hpp noremap rFor i for ()<Enter>{<Enter>}<Esc>2k=2j$i

"-auto closing for most languages (not <> because << and >> )
autocmd FileType c,cpp,h,hpp inoremap ( ()<Left>
autocmd FileType c,cpp,h,hpp inoremap { {<Enter>}<Esc>k$i<Right>
autocmd FileType c,cpp,h,hpp inoremap " ""<Left>
autocmd FileType c,cpp,h,hpp inoremap ' ''<Left>
autocmd FileType c,cpp,h,hpp inoremap [ []<Left>
autocmd FileType c,cpp,h,hpp nnoremap ; A;<Esc>


"-wrap selection in quotes, parenthesis, or {} brackets w/ indent
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap " <ESC>`>a"<ESC>`<i"<ESC>
vnoremap { <ESC>`>a<Enter>}<ESC>`<i{<Enter><ESC>`<=i{

" Make the dot command work as expected in visual mode
vnoremap . :norm.<CR>")"

filetype indent plugin on

syntax on

set mouse=a
set title

"-Indent
set shiftwidth=2
set autoindent

"-Key changes
set backspace=indent,eol,start


"-Search
set ignorecase
set smartcase
set hlsearch
nnoremap <C-L> :nohl<CR><C-L>

"-Paste mode (doesn't mess with indentation and mappings within copy paste)
set pastetoggle=<F2>

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
"- alt + j, move current line down 1, alt + k, move current line up 1 (also works with visal mode)
nnoremap gj :m .+1<CR>==
nnoremap gk :m .-2<CR>==
vnoremap gj :m '>+1<CR>gv=gv
vnoremap gk :m '<-2<CR>gv=gv
