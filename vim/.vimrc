" Nanozuki Vim Config

" basic & misc {{{
" unicode support
let $LANG="en_US.UTF-8"
set langmenu=en_US.UTF-8
set encoding=UTF-8
set fileencodings=utf-8
set termencoding=utf-8

"" leader
let mapleader=" "

filetype on
filetype plugin on
set backspace=indent,eol,start
set mouse=a
" }}}

" appearance {{{
"" colorscheme
set termguicolors
set background=light
colorscheme gruvbox
let g:gruvbox_italic=1

"" ui layout
set number
set relativenumber
set ruler
" set cursorline
" set cursorcolumn
set laststatus=2
set colorcolumn=80
" }}}

" shortcuts {{{
"" switch window
nnoremap <Leader>nw <C-W><C-W>
nnoremap <Leader>lw <C-W>l
nnoremap <Leader>hw <C-W>h
nnoremap <Leader>kw <C-W>k
nnoremap <Leader>jw <C-W>j

"" session
nnoremap <leader>ss :mksession! ./.vimsession<cr> :wviminfo! ./.viminfo<cr>
nnoremap <leader>rs :source ./.vimsession<cr> :rviminfo ./.viminfo<cr>

nnoremap <Leader>b ^
nnoremap <Leader>e $
" }}}

" edit {{{
syntax enable
set foldmethod=indent
set foldlevelstart=99
" copy selection to system clipboard
vnoremap <Leader>y "+y
" paste from system clipboard
nnoremap <Leader>p "+p
" completion for vim command
set wildmenu
"" ignore file for all
:set wildignore+=*/node_modules/*,*.swp,*.pyc,*/venv/*,
" save as sudo
cmap w!! w !sudo tee %
" }}}

" search & replace {{{
set modelines=1
set hlsearch
nnoremap <leader>/ :nohlsearch<CR>
set incsearch
set ignorecase
" }}}

" indent {{{
filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
augroup fileindent
    autocmd BufRead,BufNewFile *html setfiletype html
    autocmd FileType javascript setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType html setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType css setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType scss setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType xml setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType yaml setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType json setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType wxss setlocal expandtab ts=2 sw=2 sts=2
    autocmd FileType wxml setlocal expandtab ts=2 sw=2 sts=2
augroup end
" }}}

" [plugin] airline {{{
let g:airline_theme="gruvbox"
let g:airline_powerline_fonts=1
let g:airline_extensions=['tabline', 'branch', 'virtualenv']
" let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#tabline#buffer_nr_show=1
" }}}

" [plugin] indentline {{{
set list lcs=tab:\¦\ 
autocmd Filetype json let g:indentLine_enabled = 0
" }}}

" [plugin] coc {{{
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for https://github.com/itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" golang: auto imports
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
" }}}

" [plugin] ultisnips {{{
let g:UltiSnipsExpandTrigger="<c-b>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}

" [plugin] ale {{{
let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\}
let g:ale_fix_on_save = 1
let g:ale_linters = {
\   'go': ['gofmt', 'golangci-lint'],
\}
let g:ale_go_golangci_lint_package = 1
let g:ale_go_golangci_lint_options = "--config $XDG_CONFIG_HOME/nvim/golangci.yml"
" }}}

" [plugin] nerdtree {{{
nmap <Leader>fl :NERDTreeToggle<CR>
let NERDTreeWinSize=32
let NERDTreeWinPos="left"
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
" }}}

" [plugin] ctrlsf {{{
let g:ctrlsf_ackprg = 'rg'
nmap <leader>sf :CtrlSF 
nmap <leader>sp :CtrlSF<CR>
" }}}

" [plugin] vim-jsx {{{
let g:jsx_ext_required = 0
" }}}

" [plugin] vim-go {{{
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_enable= 1
let g:go_metalinter_command="golangci-lint"
" }}}

" [plugin] vim-plug {{{
call plug#begin('~/.vim/plugins')
" appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'
Plug 'morhetz/gruvbox'
" edit code
Plug 'kshenoy/vim-signature'
Plug 'scrooloose/nerdcommenter'
Plug 'easymotion/vim-easymotion'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
" Plug 'SirVer/ultisnips'
" Plug 'CrowsT/vim-snippets'
" read code
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'dyng/ctrlsf.vim'
Plug 'kien/ctrlp.vim'
Plug 'BurntSushi/ripgrep'
" javascript/react
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mattn/emmet-vim', { 'for': ['javascript', 'html'] }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim'
" go
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoUpdateBinaries' }
Plug 'buoto/gotests-vim', { 'for': 'go' }
" fish
Plug 'dag/vim-fish'

""" Initialize plugin system
call plug#end()
" }}}

" vim:foldmethod=marker:foldlevel=0
