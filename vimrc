"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible " VI compatible mode is disabled so that VIm things work
set belloff=all  " Remove annoying bell sounds

"=============================================================================
"   PLUGINS...
" =============================================================================
call plug#begin() " Uses plug.vim in ./vim/autoload

" Load plugins
" Per file editor config ========================================
Plug 'ciaranm/securemodelines'
Plug 'editorconfig/editorconfig-vim' " Change indent_{style|size}, tab_width, etc.

" GUI enhancements ===============================================
Plug 'itchyny/lightline.vim'          " Better Status Bar
Plug 'mhinz/vim-startify'             " Better start screen
Plug 'scrooloose/nerdtree'            " File explorer
" Plug 'ryanoasis/vim-devicons'         " Nice filetype icons (slow)

" NERDtree Navigation ============================================
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs' " fzf is a better alternative

" Automcomplete and Folding and Formatting =======================
Plug 'Valloric/YouCompleteMe'         " Auto-Complete
Plug 'tmhedberg/SimpylFold'	      " Folding
Plug 'vim-scripts/indentpython.vim'   " Python Indenting 

" Search, Find and Jump ==========================================
Plug 'junegunn/fzf'		      " Fuzzu finder
Plug 'romainl/vim-cool'               " Disables highlight when search is done
Plug 'haya14busa/incsearch.vim'       " Better incremental search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }  " FZF plugin, makes Ctrl-P unnecessary
Plug 'junegunn/fzf.vim'
" Plug 'kien/ctrlp.vim'		      " Start searching with Ctrl-P

" Git =============================================================
Plug 'tpope/vim-fugitive'            " See it onaction on VIMcasts
Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " Display git and others


" Initialize plugin system
call plug#end()

" ================ END  PLUGINS  ================================

let mapleader=" "             " leader is space

set nu rnu
set encoding=utf-8

" =============================================================================
"  Formattings
"  ============================================================================

" Folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
" nnoremap <space> za " Used as leader above
" SimpylFold Customizations
let g:SimpylFold_docstring_preview=1


" Python PEP8 Reformatting
au BufNewFile,BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix

" Web stack Refromatting
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" Flag extraneous whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" =====================================================
" NERDTree Customizations
" =====================================================
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" =================== SPLITS ============================
set splitbelow
set splitright

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-L><C-H>
nnoremap <C-L> <C-W><C-L>
