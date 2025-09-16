" install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" install plugins
call plug#begin()
" sensible defaults most people agree to
Plug 'tpope/vim-sensible'
" colorschemes
Plug 'morhetz/gruvbox'
" status line
Plug 'itchyny/lightline.vim'
" lsp support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" asyncronously run commands
Plug 'skywind3000/asyncrun.vim'
" latex support 
Plug 'lervag/vimtex'
" autopairs for brackets
Plug 'jiangmiao/auto-pairs'
" press <ctrl+E> to adjust split sizes
Plug 'simeji/winresizer'
" comment out selected lines
Plug 'preservim/nerdcommenter'
" typst syntax highlighting
Plug 'kaarmu/typst.vim'
" file tree
Plug 'preservim/nerdtree'
call plug#end()

" remap jj to leave insert mode
inoremap jj <Esc>

" adjust tabs
set tabstop=4       " Number of spaces that a <Tab> counts for
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent
set expandtab       " Use spaces instead of actual tab characters

" Keep the cursor vertically centered
set scrolloff=999

" capitalization in search set ignorecase    " Always ignore case in search
set smartcase     " Unless the search includes capital letters

" set default height of the quickfix menu
autocmd FileType qf wincmd J | resize 8

" disable mouse support
set mouse=

" show relative line numbers
set relativenumber
set number

" Enable line wrapping
set wrap
" wrap visually instead of breaking words mid-line
set linebreak
" Make j/k move by screen line when lines are wrapped
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
onoremap j gj
onoremap k gk
" Remap 0 and $ to screen line motions
noremap 0 g0
noremap $ g$
xnoremap 0 g0
xnoremap $ g$
onoremap 0 g0
onoremap $ g$

" Jump to the last known cursor position when reopening a file
augroup restore_cursor_position
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" Enable spell checking for Markdown and TeX with English + German
" autocmd FileType markdown,tex setlocal spell spelllang=en,de
autocmd FileType tex,typst setlocal spell spelllang=en,de

" adjust vim to the kitty terminal
if exists('$KITTY_WINDOW_ID') || &term =~ 'xterm-kitty'
	let &t_SI = "\e[6 q"   " Insert mode: bar cursor
	let &t_EI = "\e[2 q"   " Normal mode: block cursor
	let &t_SR = "\e[4 q"   " Replace mode: underline cursor
endif

" point vim to the python exe I want to use
let g:python3_host_prog = '/home/aaron/miniconda3/bin/python'

" set the colorscheme
if has("termguicolors")
	set termguicolors
endif
set background=dark
colorscheme gruvbox
" Auto-open quickfix window if AsyncRun produces output
let g:asyncrun_open = 6

" adjust things coc.nvim related
" highlights variables and their definitions
autocmd CursorHold * silent call CocActionAsync('highlight')
" use tab for everything like in vscode
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" configure vimtex
let g:vimtex_quickfix_mode = 0 " dont open quickfix menu automatically
let g:vimtex_view_general_viewer = "okular"
let g:vimtex_view_general_options = "--unique file:@pdf#src:@line@tex"

" Toggle NERDTree                                                                                                   
nnoremap <F2> :NERDTreeToggle<CR>
