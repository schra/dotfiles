" Ubuntu-specific: by querying for python3, py3 is loaded instead of py2
if has('python3')
endif

call plug#begin('~/.local/share/nvim/plugged')
Plug 'liuchengxu/space-vim-dark'
Plug 'airblade/vim-gitgutter'
Plug 'hashivim/vim-terraform'
Plug 'rhysd/conflict-marker.vim'
call plug#end()

" gitgutter: By default, gitgutter will show an additional column that shows
" the diff. Instead, I configured gitgutter to adjust the background of the
" line numbers accordingly.
"
" make "Add" green and "Change" yellow
highlight link GitGutterAdd          DiffChange
highlight link GitGutterChange       DiffAdd
highlight link GitGutterDelete       DiffDelete
highlight link GitGutterChangeDelete GitGutterChange
" make "Add" green and "Change" yellow
highlight link GitGutterAddLine          DiffChange
highlight link GitGutterChangeLine       DiffAdd
highlight link GitGutterDeleteLine       DiffDelete
highlight link GitGutterChangeDeleteLine DiffChange
" by default the line number background color is always the same
highlight link GitGutterAddLineNr          GitGutterAddLine
highlight link GitGutterChangeLineNr       GitGutterChangeLine
highlight link GitGutterDeleteLineNr       GitGutterDeleteLine
highlight link GitGutterChangeDeleteLineNr GitGutterChangeDeleteLine
" gitgutter will create a sign column by default, completely remove it since
" we only use gitgutter to highlight line numbers
let g:gitgutter_signs = 0
set signcolumn=no
" highlight line numbers
let g:gitgutter_highlight_linenrs = 1
" update the diff every 100ms (default is 4s)
set updatetime=100

" enable syntax highlighting
syntax on

" show line numbers
set number

" highlight current line
set cursorline

" enable the mouse
set mouse=a

" https://wiki.archlinux.org/index.php/Neovim#Loading_vim_addons
set rtp^=/usr/share/vim/vimfiles/

" indentation
" indents will have a width of 2 spaces
set shiftwidth=2
" number of spaces Vim will display tabs as
set tabstop=2
" expand tabs to spaces
set expandtab
" this is a weird option. Just set it to "tabstop"
set softtabstop=2

" show leading and trailing spaces and tabs
set listchars=tab:»\ ,trail:·
set list

" see https://vi.stackexchange.com/a/10125
filetype plugin indent on

" smartindent doesn't indent comments
"
" This is not so great in Markdown/ reST/ .. where you have to indent code and
" if that code contains comments, then they won't be indented
" https://stackoverflow.com/questions/191201/indenting-comments-to-match-code-in-vim
set nosmartindent

" move line by line on the screen rather than by line in the file
map j gj
map k gk

" set color scheme
" see https://github.com/liuchengxu/space-vim-dark#installation
colorscheme space-vim-dark
hi Comment guifg=#5C6370 ctermfg=59
set termguicolors
hi LineNr ctermbg=NONE guibg=NONE

" activate spell checking
"
" we need to use both "setlocal" and "setglobal" to activate spell checking in
" *all* tabs
setlocal spell spelllang=en_us,de_de
setglobal spell spelllang=en_us,de_de
hi SpellBad cterm=underline,bold ctermfg=white ctermbg=red 

" copy and paste to system clipboard
"
" Beforehand I used the mappings from https://stackoverflow.com/a/16582932.
" But these are problematic since C-a, C-v, and C-x are already mapped by
" default.
set clipboard=unnamedplus

" jump to the last position when reopening a file
" https://askubuntu.com/questions/202075/how-do-i-get-vim-to-remember-the-line-i-was-on-when-i-reopen-a-file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" search for the selected text
" https://vim.wikia.com/wiki/Search_for_visually_selected_text
function! s:getSelectedText()
  let l:old_reg = getreg('"')
  let l:old_regtype = getregtype('"')
  norm gvy
  let l:ret = getreg('"')
  call setreg('"', l:old_reg, l:old_regtype)
  exe "norm \<Esc>"
  return l:ret
endfunction

" by default, Vim selects the current word unter the cursor (i.e. not the
" current selection)
vnoremap <silent> * :call setreg("/",
    \ substitute(<SID>getSelectedText(),
    \ '\_s\+',
    \ '\\_s\\+', 'g')
    \ )<Cr>n

let mapleader = " "

" this executes my compile alias (see my dotfiles' README.md)
nnoremap <leader>c :!c<cr>

" :cd into the folder of the current file
" https://vim.fandom.com/wiki/Set_working_directory_to_the_current_file
" h for cHange directory
nnoremap <leader>h :cd %:p:h<cr>

" save undo history
"
" There is also an alternative way to archive this: See
" https://stackoverflow.com/questions/2732267/vim-loses-undo-history-when-changing-buffers
set hidden

" create a new line and keep the current line's indentation
"
" I modified the suggested snippets from
" https://vim.wikia.com/wiki/Insert_newline_without_entering_insert_mode, so
" that the cursor doesn't "loose" the indentation that you create with "o".
" The first "x" just writes the char "x" and the second "x" deletes this "x"
" again. Furthermore "_x intends to avoid yanking the char "x" into a
" register. See https://stackoverflow.com/a/54434
nmap <s-cr> ox<Esc>"_x
" create a new line and don't keep indentation
nmap <cr> o<Esc>

" https://vim.wikia.com/wiki/Automatically_set_screen_title
set title
autocmd BufEnter * let &titlestring = "nvim " . expand("%:t")

" color the 81th character on a line
" https://www.youtube.com/watch?v=aHm36-na4-4
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" print the current date
" d like date
nnoremap <leader>d i<enter><esc>ki<C-R>=strftime('%a %Y-%m-%d')<cr><esc>ddPPjVr-o<enter>

" t as in title
" you e.g. type <leader>t= for getting the line underlined with =
noremap <leader>t YpVr
" I often forget to press shift -> I type a 0 instead of a =
noremap <leader>t0 YpVr=

" configure conflict-marker
highlight ConflictMarkerBegin guibg=#2f7366
highlight ConflictMarkerOurs guibg=#2e5049
highlight ConflictMarkerTheirs guibg=#344f69
highlight ConflictMarkerEnd guibg=#2f628e
