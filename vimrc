let s:en_spellfile = expand("~/linuxconfigs/en.utf-8.add")
let s:en_replacefile = expand("~/linuxconfigs/textidote_replacements.txt")

call plug#begin('~/.vim/vplugindir')

" Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py' }
Plug 'sirver/ultisnips'
let g:UltiSnipsExpandTrigger = '<C-l>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsEditSplit="tabdo"

Plug 'tpope/vim-fugitive'

Plug 'tpope/vim-obsession'
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method = 'zathura'
set conceallevel=0
let g:UltiSnipsEditSplit="vertical"

Plug 'mileszs/ack.vim'

Plug 'preservim/nerdtree'
Plug 'vim-scripts/nerdtree-ack'

Plug 'dbakker/vim-projectroot'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'
Plug 'whonore/Coqtail'

Plug 'PatrBal/vim-textidote'
let g:textidote_jar = '/opt/textidote/textidote.jar'
let g:textidote_win_height = 10
let g:textidote_lang = 'en'
let g:textidote_dictionary = s:en_spellfile
let g:textidote_ignore_macros = 'qw,quad,gate,ghost,Qcircuit,hfill'
let g:textidote_replacements = s:en_replacefile
vnoremap <silent> <Leader>te :'<,'>TeXtidoteToggle<CR>
nnoremap <silent> <Leader>te :TeXtidoteToggle<CR>

Plug 'github/copilot.vim'
let g:copilot_filetypes = {
  \ 'copilot_chat': v:false,
\ }


Plug 'DanBradbury/copilot-chat.vim'
let g:copilot_chat_create_on_add_selection = 1
nnoremap <silent> <leader>cc :CopilotChatOpen<CR>i
tnoremap <silent> <leader>cc <C-w>:CopilotChatOpen<CR>i
vnoremap <leader>ca <Plug>CopilotChatAddSelection ki


call plug#end()



" May need to
"   filetype off
"   syntax off

function SetLatexOptions()
    set shiftwidth=2
    set foldmethod=expr
    set foldlevel=999
    set spelllang=en
    execute "set spellfile=" . s:en_spellfile
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

function SetCPChatOptions()
    "- set nospell
    "- set nosmartindent
    "- inoremap <CR> <C-o>:CopilotChatSubmit<CR>
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
set shiftwidth=2

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
autocmd BufEnter * call SetProjectRoot()

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

function! SetProjectRoot()
  try
    let b:workspace_folder = ProjectRootGuess()
  catch
    " Do nothing
  endtry
endfunction

set number
set relativenumber
set encoding=utf-8
augroup ExtensionSpec
    autocmd!
    autocmd FileType c,cpp,h,hpp,py,java call SetMostOptions()
    autocmd FileType c,cpp,h,hpp call SetCppOptions()
    autocmd FileType tex call SetLatexOptions()
    autocmd FileType copilot_chat call SetCPChatOptions()
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
" RCD = Change to Directory of Current project
command RCD ProjectRootCD

def g:Tapi_lcd(_, path: string)
    if isdirectory(path)
        execute 'silent lcd ' .. fnameescape(path)
    endif
enddef

def g:Tapi_hvim(_, path: string)
    execute 'vsplit ' .. fnameescape(path)
enddef
def g:Tapi_jvim(_, path: string)
    execute 'belowright split ' .. fnameescape(path)
enddef
def g:Tapi_kvim(_, path: string)
    execute 'split ' .. fnameescape(path)
enddef
def g:Tapi_lvim(_, path: string)
    execute 'belowright vsplit ' .. fnameescape(path)
enddef

" Quick Beluga support
augroup Beluga
  autocmd!
  au BufRead,BufNewFile *.bel setfiletype bel
augroup END


" Edit vimrc (https://superuser.com/questions/132029/how-do-you-reload-your-vimrc-file-without-restarting-vim)
nnoremap <leader>ev :tabe $MYVIMRC<CR>
tnoremap <leader>ev <C-w>:tabe $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
tnoremap <leader>sv <C-w>:source $MYVIMRC<CR>

set tags=./tags;$HOME

"U
let $PATH .= ':/usr/local/texlive/2025/bin/x86_64-linux'

" Copilot chat -> quickfix
function! s:make_prompt(fname, ft, content) abort
  return join([
        \ 'You are to analyze the following file and return ONLY a valid JSON array.',
        \ 'Each element must be an object: { "filename": "<string>", "lnum": <integer>, "col": <integer, optional>, "text": "<string>" }',
        \ 'Include an item for each grammar, spelling, and style suggestion. Be concise.',
        \ 'DO NOT output any explanatory text, markdown, or code fences — ONLY the JSON array.',
        \ printf('Filetype: %s, Filename: %s', a:ft, a:fname),
        \ '',
        \ 'File contents begin:',
        \ a:content,
        \ 'File contents end.'
        \ ], "\n")
endfunction



function! ExtractJSON(bufnr, start_line, end_line) abort
  " gather tail lines excluding the separator
  let l:lines = getbufline(a:bufnr, a:start_line, a:end_line - 2)
  let l:raw = join(l:lines, "\n")

  " decode JSON array
  try
    let l:items = json_decode(l:raw)
  catch
    throw 'Failed to decode JSON: ' . v:exception
  endtry

  if type(l:items) != type([])
    throw 'Decoded JSON is not an array'
  endif

  return l:items
endfunction

let s:__wait_state = {}

function! s:__wait_for_buffer_fill(tid) abort
  try
    let state = s:__wait_state[a:tid]
  catch
    return
  endtry
  let l:end_line = line('$', win_findbuf(state.bufnr)[0])
  if l:end_line > state.start_line
    call timer_stop(a:tid)
    call remove(s:__wait_state, a:tid)
    call ApplyJsonToQuickfix(ExtractJSON(state.bufnr, state.start_line, l:end_line), state.orig_win, state.bufnr)
    return
  endif
  if reltimefloat(reltime(state.start_time)) * 1000.0 >= state.timeout
    call timer_stop(a:tid)
    call remove(s:__wait_state, a:tid)
    throw '__wait_for_buffer_fill: timeout'
  endif
endfunction

function! CopilotChatQuickfix() abort
  " save context
  let l:orig_buf = bufnr('%')
  let l:orig_win = win_findbuf(l:orig_buf)
  let l:fname = expand('%:p')
  if l:fname ==# '' | let l:fname = 'buffer' | endif
  let l:ft = &filetype
  if l:ft ==# '' | let l:ft = 'text' | endif
  let l:content = join(getline(1, '$'), "\n")
  let l:prompt = s:make_prompt(l:fname, l:ft, l:content)

  " open Copilot chat
  CopilotChatOpen
  let l:input_buf = bufnr('%')
  call append(line('$'), split(l:prompt, "\n"))
  normal! G
  let l:start_line = line('$') + 2
  CopilotChatSubmit
  " return to original buffer
  let state = {
        \ 'bufnr': l:input_buf,
        \ 'orig_win' : l:orig_win[0],
        \ 'start_line': l:start_line,
        \ 'start_time': reltime(),
        \ 'timeout': 120000
        \ }
  let tid = timer_start(200, 's:__wait_for_buffer_fill', {'repeat': -1})
  let s:__wait_state[tid] = state
endfunction

function! ApplyJsonToQuickfix(json_items, orig_win, input_buf) abort
  " Optional basic validation/normalization (ensure required keys and numeric lnum/col)
  for idx in range(len(a:json_items))
    let item = a:json_items[idx]
    if type(item) != type({})
      throw 'Quickfix item ' . idx . ' is not an object'
    endif
    if !has_key(item, 'filename') && !has_key(item, 'bufnr')
      throw 'Quickfix item ' . idx . ' missing filename or bufnr'
    endif
    if has_key(item, 'lnum')
      let item.lnum = str2nr(item.lnum)
      if item.lnum < 1 | let item.lnum = 1 | endif
    else
      let item.lnum = 1
    endif
    if has_key(item, 'col')
      let item.col = str2nr(item.col)
      if item.col < 1 | let item.col = 1 | endif
    endif
    if !has_key(item, 'text')
      let item.text = ''
    endif
    let a:json_items[idx] = item
  endfor

  " Set quickfix and open
  execute 'silent! bd! ' . a:input_buf
  call win_gotoid(a:orig_win)
  LCD
  windo call setqflist(a:json_items, 'r')
  botright copen
endfunction

command! CPReview call CopilotChatQuickfix()

