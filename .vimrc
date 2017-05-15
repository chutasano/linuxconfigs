"-if/while/for for c++
autocmd FileType c,cpp,h,hpp noremap rif iif ()<Enter>{<Enter>}<Esc>2k=2j$i
autocmd FileType c,cpp,h,hpp noremap rwhile iwhile ()<Enter>{<Enter>}<Esc>2k=2j$i
for i in split('abcdefghijklmnopqrstuvwxyz', '\zs')
    execute printf("autocmd FileType c,cpp,h,hpp noremap rfor%s i for (int %s = 0; %s < ; %s++)<Enter>{<Enter>}<Esc>2k=2j$5hi", i, i, i, i)
endfor
autocmd FileType c,cpp,h,hpp noremap rFor i for ()<Enter>{<Enter>}<Esc>2k=2j$i

"-auto closing for most languages (not <> because << and >> )
inoremap ( ()<Left>
inoremap { {<Enter>}<Esc>k$i<Right>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap [ []<Left>
"-inoremap <expr> <Esc>; SemicolHandler()
inoremap <Esc>; <End>;
inoremap <Esc>= <Esc>==a

func SemicolHandler()
  if (col("." >= col("$")-1)) && getline(".")[col(".")-1] != ';'
    return ;
  else
    return <End>;
  endif
endfunc

nnoremap <Enter> $a<Enter><ESC>


"-wrap selection in quotes, parenthesis, or {} brackets w/ indent
vnoremap ( <ESC>`>a)<ESC>`<i(<ESC>
vnoremap " <ESC>`>a"<ESC>`<i"<ESC>
vnoremap { <ESC>`>a<Enter>}<ESC>`<i{<Enter><ESC>`<=i{


filetype indent plugin on

syntax on

set mouse=a

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

"-Center screen
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>
