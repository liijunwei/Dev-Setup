set nocompatible
set backspace=indent,eol,start
syntax on
set showmode
set fileformats=unix,dos
set encoding=utf-8
filetype plugin indent on
set completeopt=menu,preview,longest
set autoindent
set smartindent
set smarttab
set tabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:»\ ,trail:·
set conceallevel=2
set concealcursor=""
set number
set ruler
set colorcolumn=80,100,120,140
set cursorline
set foldenable
set foldmethod=indent
set foldlevel=10
set scrolloff=3
set sidescroll=10
set linebreak
set nowrap
set whichwrap=b,s,<,>,[,]
set showmatch
set hlsearch
execute 'nohlsearch'
set incsearch
set ignorecase
set smartcase
set autochdir
set visualbell
set autoread
set updatetime=200
set showcmd
set wildmenu
set wildmode=longest:list,full
set completeopt=longest,menu
set background=dark
set t_Co=256
set guifont=DejaVuSansMonoNerdFontCompleteM-Book:h14
set linespace=2
colorscheme monokai

if has('mouse')
    set mouse=a
endif
if &term =~ 'xterm'
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

autocmd GUIEnter * set lines=45 columns=160

autocmd GUIEnter * set spell spelllang=en_us

autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
autocmd BufWritePre,FileWritePre * RemoveTrailingSpaces

let g:tex_flavor = 'latex'
autocmd Filetype sh,zsh,gitconfig,c,cpp,make,go set noexpandtab
autocmd Filetype text,markdown,rst,asciidoc,tex set wrap
autocmd FileType vim,tex let b:autoformat_autoindent = 0

let g:NERDTreeMouseMode = 2
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowFiles = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeWinPos = 'left'
let g:NERDTreeWinSize = 31
let g:NERDTreeNotificationThreshold = 200
let g:NERDTreeAutoToggleEnabled = (!&diff && argc() > 0)
let s:NERDTreeClosedByResizing = 1
function s:NERDTreeAutoToggle(minbufwidth = 80)
    if g:NERDTreeAutoToggleEnabled && !(exists('b:NERDTree') && b:NERDTree.isTabTree())
        let NERDTreeIsOpen = (g:NERDTree.ExistsForTab() && g:NERDTree.IsOpen())
        let width = winwidth('%')
        let numberwidth = ((&number || &relativenumber) ? max([&numberwidth, strlen(line('$')) + 1]) : 0)
        let signwidth = ((&signcolumn == 'yes' || &signcolumn == 'auto') ? 2 : 0)
        let foldwidth = &foldcolumn
        let bufwidth = width - numberwidth - foldwidth - signwidth
        if bufwidth >= a:minbufwidth + (g:NERDTreeWinSize + 1) * (1 - NERDTreeIsOpen)
            if !NERDTreeIsOpen && s:NERDTreeClosedByResizing
                if str2nr(system('find "' . getcwd() . '" -mindepth 1 -maxdepth 1 | wc -l')) <= g:NERDTreeNotificationThreshold
                    NERDTree
                    wincmd p
                    let s:NERDTreeClosedByResizing = 0
                endif
            endif
        elseif NERDTreeIsOpen && !s:NERDTreeClosedByResizing
            NERDTreeClose
            let s:NERDTreeClosedByResizing = 1
        endif
    endif
endfunction
autocmd VimEnter,VimResized * call s:NERDTreeAutoToggle(80)
autocmd BufEnter * if winnr('$') == 1 && (exists('b:NERDTree') && b:NERDTree.isTabTree()) | quit | endif

let g:airline#extensions#tabline#enabled = 1

let g:bufferline_echo = 0

let g:undotree_WindowLayout = 3

if &diff
    let &diffexpr = 'EnhancedDiff#Diff("git diff", "--diff-algorithm=histogram")'
endif
let g:DirDiffExcludes = ".git,.svn,.hg,CVS,.idea,.*.swp,*.pyc,__pycache__"
autocmd VimResized * if &diff | wincmd = | endif

let g:indentLine_char_list = ['|', '¦', '┆', '┊']

let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

let g:indentLine_setConceal = 0

let g:rainbow_active = 1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_wq = 0
autocmd GUIEnter * let g:syntastic_check_on_open = 1

let g:ycm_python_interpreter_path = trim(system('realpath $(which python3)'))
let g:ycm_cache_omnifunc = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
autocmd InsertLeave * if pumvisible() | pclose | endif
inoremap <expr> <CR>       pumvisible() ? "\<C-y>\<Esc>a" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
let g:ycm_key_list_stop_completion = ['<C-y>']
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']

if !exists('$SSH_CONNECTION')
    let g:mkdp_auto_start = 1
endif

call plug#begin('~/.vim/plugged')
    Plug 'flazz/vim-colorschemes'
    Plug 'mhinz/vim-startify'
    Plug 'preservim/nerdtree'
    Plug 'preservim/nerdcommenter'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'bling/vim-bufferline'
    Plug 'chrisbra/vim-diff-enhanced'
    Plug 'will133/vim-dirdiff'
    Plug 'yggdroot/indentline'
    Plug 'luochen1990/rainbow'
    Plug 'jaxbot/semantic-highlight.vim'
    Plug 'chrisbra/Colorizer'
    Plug 'jiangmiao/auto-pairs'
    Plug 'tpope/vim-surround'
    Plug 'mg979/vim-visual-multi'
    Plug 'tpope/vim-unimpaired'
    Plug 'mbbill/undotree'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'liuchengxu/vista.vim'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
    Plug 'junegunn/fzf.vim'
    Plug 'vim-autoformat/vim-autoformat'
    Plug 'vim-syntastic/syntastic'
    Plug 'codota/tabnine-vim'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'PProvost/vim-ps1'
    Plug 'elzr/vim-json'
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim'
    Plug 'lervag/vimtex'
    Plug 'vim/killersheep'
call plug#end()
