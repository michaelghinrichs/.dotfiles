" Michael Hinrichs' vimrc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim.plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set encoding=utf-8
let mapleader = " "

" No sql shit
let g:omni_sql_no_default_maps = 1

" allow unsaved background buffers and remember marks/undo for them
set hidden

" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch

" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase

" highlight current line
set cursorline

" Always show current position
set ruler
set relativenumber
set number
set switchbuf=useopen
set numberwidth=6
set winwidth=90
set tags=tags;/

" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=

" keep more context when scrolling off the end of a buffer
set scrolloff=3

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" display incomplete commands
set showcmd

" Enable highlighting for syntax
syntax on

" 'cindent' is on in C files, etc.
" load indent files, to automatically do language-dependent indenting.
filetype plugin on
filetype plugin indent on

" set .md as markdown files for syntax highlighting
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" make tab completion for files/buffers act like bash
set wildmenu

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

""ctags custom mappings
"map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
"map <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Start interactive EasyAlign in visual mode
vmap <Enter> <Plug>(EasyAlign)
"
" Start interactive EasyAlign with a Vim motion
nmap <Leader>a <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
" Jump to last cursor position unless it's invalid or in an event handler
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal g`\"" |
    \ endif

    "for ruby, autoindent with two spaces, always expand tabs
    autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et

    autocmd BufRead, BufNewFile *.sass setfiletype sass
augroup END

" Spell checking and AutoCompleting
autocmd FileType gitcommit setlocal spell textwidth=72
autocmd BufRead,BufNewFile *.md setlocal spell
set complete+=kspell

" Save current color to file
command SaveCurrentColor execute ":redir >> ~/.dotfiles/nice-colorschemes.md | echo g:colors_name | redir END"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLOR
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set guioptions-=T
set t_Co=256 " 256 colors
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey
autocmd VimEnter * RandomColorScheme
set background=dark

" When you just need a nice color
nmap <leader>1 :colorscheme flatlandia<cr>
nmap <leader>2 :colorscheme busybee<cr>
nmap <leader>3 :colorscheme bvemu<cr>
nmap <leader>4 :colorscheme apprentice<cr>
nmap <leader>5 :colorscheme gotham256<cr>
nmap <leader>6 :colorscheme iceberg<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC KEY MAPS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" Fast buffer closing
nmap <leader>q :bd<cr>

" Fast vim closing
nnoremap <leader>qq :q<cr>

" Switch back to previous file
nnoremap <leader><leader> <c-^>

" use K to do the opposite of J
nnoremap K i<CR><Esc>

" EXPERIMENTAL move through buffers from home
map <leader>l :bn<CR>
map <leader>h :bp<CR>

" Control-C to return to Command Mode
imap <c-c> <esc>

" Clear the search buffer when hitting return
function! MapCR()
    nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" " Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
       return "\<tab>"
    else
       return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Leader>f :FZF<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim Multiple Cursors
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-c>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Files and backups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linters / Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable :lnext and :lprev
let g:syntastic_always_populate_loc_list = 1

"SCSS-lint
let g:syntastic_scss_checkers = ['scss_lint']

"eslint linter
let g:syntastic_javascript_checkers = ['eslint']

"JSX syntax Highlighting everywhere
let g:jsx_ext_required = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerd Tree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add control slash and command slash (like atom) to collapse and expand
map <C-o> :NERDTreeToggle<CR>

" change default arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"close NERDTree if it is only window left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
" http://stackoverflow.com/questions/4789605/how-do-i-enable-automatic-folds-in-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax
set foldlevelstart=1
let javaScript_fold=1
autocmd BufWinEnter * silent! :%foldopen!
"experimental
" autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
" autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggles
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" enable mouse usage
set mouse=a
" autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
" map <leader>t :!npm t<cr>
