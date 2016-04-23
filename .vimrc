"=======================
"|                     |
"|      基本设置       |
"|                     |
"=======================

"" 语言和编码
let $LANG="zh_CN.UTF-8"
set langmenu=zh_cn.utf-8
set encoding=utf8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8

"" 快捷键前缀
let mapleader=";"

"" 基本设置
filetype on
filetype plugin on
set backspace=2
set backspace=indent,eol,start

"" 窗口
nmap <Leader>q :q<CR>
" 定义快捷键保存当前窗口内容
nmap <Leader>w :w<CR>
" 定义快捷键保存所有窗口内容并退出 vim
nmap <Leader>WQ :wa<CR>:q<CR>
" 不做任何保存，直接退出 vim
nmap <Leader>Q :qa!<CR>
" 依次遍历子窗口
nnoremap nw <C-W><C-W>
" 跳转至右方的窗口
nnoremap <Leader>lw <C-W>l
" 跳转至方的窗口
nnoremap <Leader>hw <C-W>h
" 跳转至上方的子窗口
nnoremap <Leader>kw <C-W>k
" 跳转至下方的子窗口
nnoremap <Leader>jw <C-W>j
" 定义快捷键在结对符之间跳转，助记pair
nmap <Leader>pa %

"" 自定义命令与功能
" 设置环境保存项
set sessionoptions="blank,buffers,globals,localoptions,tabpages,sesdir,folds,help,options,resize,winpos,winsize"
" 保存 undo 历史
set undodir=~/.undo_history/
set undofile
" 保存快捷键
map <leader>ss :mksession! my.vim<cr> :wviminfo! my.viminfo<cr>
" 恢复快捷键
map <leader>rs :source my.vim<cr> :rviminfo my.viminfo<cr>

"=======================
"|                     |
"|        外观         |
"|                     |
"=======================
" 去掉菜单栏和工具栏
"set guioptions-=m
"set guioptions-=T
" 去掉滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 主题
set background=dark
colorscheme solarized
" 状态栏
let g:Powerline_colorscheme='solarized256'

" 显示设置
set number
set ruler
"set cursorline
"set cursorcolumn
set hlsearch       "高亮搜索结果
set laststatus=2   "总是显示状态栏
set colorcolumn=80 "每行不超过80字符

"=======================
"|                     |
"|   通用文件编辑      |
"|                     |
"=======================

"" 定义快捷键到行首和行尾
nmap <Leader>lb 0
nmap <Leader>le $
" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y
" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

"" 开启实时搜索功能
set incsearch
" 搜索时大小写不敏感
set ignorecase
" 关闭兼容模式
set nocompatible
" vim 自身命令行模式智能补全
set wildmenu

"" BUFFER管理器 ([plugin]MiniBufExplorer)
" 显示/隐藏 MiniBufExplorer 窗口
map <Leader>bl :MBEToggle<cr>
" buffer 切换快捷键
map <Leader>bn :MBEbn<cr>
map <Leader>bp :MBEbp<cr>
map <Leader>bd :MBEbd<cr>

"" 树形UNDO工具 ([plugin]gundo)
" 调用 gundo 树
nnoremap <Leader>ud :GundoToggle<CR>
" 开启保存 undo 历史功能
set undofile
" undo 历史保存路径
set undodir=~/.undo_history/

"" 查找与替换
" 查找 ([Plugin]ctrlsf)
nnoremap <leader>sp :CtrlSF<CR>
" 替换
" 替换函数。参数说明：
" confirm：是否替换前逐一确认
" wholeword：是否整词匹配
" replace：被替换字符串
function! Replace(confirm, wholeword, replace)
    wa
    let flag = ''
    if a:confirm
        let flag .= 'gec'
    else
        let flag .= 'ge'
    endif
    let search = ''
    if a:wholeword
        let search .= '\<' . escape(expand('<cword>'), '/\.*$^~[') . '\>'
    else
        let search .= expand('<cword>')
    endif
    let replace = escape(a:replace, '/\&~')
    execute 'argdo %s/' . search . '/' . replace . '/' . flag . '| update'
endfunction
" 不确认、非整词
nnoremap <Leader>R :call Replace(0, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 不确认、整词
nnoremap <Leader>rw :ca ([Plugin]ctrlsf)ll Replace(0, 1, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、非整词
nnoremap <Leader>rc :call Replace(1, 0, input('Replace '.expand('<cword>').' with: '))<CR>
" 确认、整词
nnoremap <Leader>rcw :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>
nnoremap <Leader>rwc :call Replace(1, 1, input('Replace '.expand('<cword>').' with: '))<CR>



"======================m
"|                     |
"|   代码阅读:通用     |
"|                     |
"=======================

" 代码高亮
syntax enable
syntax on

"" 文档标签([Plugin]vim-signature)
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "m-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "mda",
        \ 'PurgeMarkers'       :  "m<BS>",
        \ 'GotoNextLineAlpha'  :  "']",
        \ 'GotoPrevLineAlpha'  :  "'[",
        \ 'GotoNextSpotAlpha'  :  "`]",
        \ 'GotoPrevSpotAlpha'  :  "`[",
        \ 'GotoNextLineByPos'  :  "]'",
        \ 'GotoPrevLineByPos'  :  "['",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "[+",
        \ 'GotoPrevMarker'     :  "[-",
        \ 'GotoNextMarkerAny'  :  "]=",
        \ 'GotoPrevMarkerAny'  :  "[=",
        \ 'ListLocalMarks'     :  "ms",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

"" 代码折叠 基于缩进或者语法
"set foldmethod=indent
set foldmethod=syntax
set nofoldenable
" za，打开或关闭折叠；zM，关闭所有折叠；ZR，打开所有折叠

"" 代码缩进提示([Plugin]vim-indent-guides)
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
nmap <silent> <Leader>ig <Plug>IndentGuidesToggle

"" 自动生成tag([Plugin]indexer)
" 默认 --c++-kinds=+p+l，重新设置为 --c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v
" 默认 --fields=+iaS 不满足 YCM 要求，需改为 --fields=+iaSl
let g:indexer_ctagsCommandLineOptions="--c++-kinds=+p+l+x+c+d+e+f+g+m+n+s+t+u+v --fields=+iaSl --extra=+q"
" 正向遍历同名标签
nmap <Leader>tn :tnext<CR>
" 反向遍历同名标签
nmap <Leader>tp :tprevious<CR>

"" 标签窗口 ([Plugin]tagbar)
" 设置 tagbar 子窗口的位置出现在主编辑区的左边 
let tagbar_left=1 
" 设置显示／隐藏标签列表子窗口的快捷键。速记：tag list 
nnoremap <Leader>tl :TagbarToggle<CR> 
" 设置标签子窗口的宽度 
let tagbar_width=32 
" tagbar 子窗口中不显示冗余帮助信息 
let g:tagbar_compact=1
" 设置 ctags 对哪些代码元素生成标签
let g:tagbar_type_cpp = {
    \ 'kinds' : [
        \ 'd:macros:1',
        \ 'g:enums',
        \ 't:typedefs:0:0',
        \ 'e:enumerators:0:0',
        \ 'n:namespaces',
        \ 'c:classes',
        \ 's:structs',
        \ 'u:unions',
        \ 'f:functions',
        \ 'm:members:0:0',
        \ 'v:global:0:0',
        \ 'x:external:0:0',
        \ 'l:local:0:0'
     \ ],
     \ 'sro'        : '::',
     \ 'kind2scope' : {
         \ 'g' : 'enum',
         \ 'n' : 'namespace',
         \ 'c' : 'class',
         \ 's' : 'struct',
         \ 'u' : 'union'
     \ },
     \ 'scope2kind' : {
         \ 'enum'      : 'g',
         \ 'namespace' : 'n',
         \ 'class'     : 'c',
         \ 'struct'    : 's',
         \ 'union'     : 'u'
     \ }
\ }

"" 文件列表窗口([plugin]NERDTree)
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

"=======================
"|                     |
"|   代码编写:通用     |
"|                     |
"=======================

"" 缩进
filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" 某些文件类型的特别缩进
autocmd FileType javascript setlocal expandtab ts=2 sw=2 sts=2
autocmd FileType html setlocal expandtab ts=2 sw=2 sts=2
autocmd FileType css setlocal expandtab ts=2 sw=2 sts=2
autocmd FileType xml setlocal expandtab ts=2 sw=2 sts=2
autocmd FileType json setlocal expandtab ts=2 sw=2 sts=2

"" 快速开关注释 ([Plugin]NERD Commenter)
" 操作方式
" <leader>cc 注释选中文本
" <leader>cu 全校是是选中文本

"" 绘制ASCII Art风格的注释([Plugin]DrawIt)
" :Distart 开始绘制
" :Distop 停止绘制

"" 智能提示 ([Plugin]YCM)
nnoremap <leader>jd :YcmCompleter GoToDeclaration<CR>
" 只能是 #include 或已打开的文件
nnoremap <leader>je :YcmCompleter GoToDefinition<CR>
" 补全菜单配色 ([Plugin]YCM)
" 菜单
"highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
" 选中项
"highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 标签补全引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags
set tags+=/home/crows/.vim/mytags/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全         
let g:ycm_seed_identifiers_with_syntax=1

""" diff
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" 模板补全 ([Plugin]UltiSnips)
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><tab>"
let g:UltiSnipsJumpBackwardTrigger="<leader><s-tab>"

" 静态语法检查 ([Plugin] syntastic)
let g:syntastic_error_symbol='メ'
let g:syntastic_warning_symbol='!'

" 结对符补全 ([Plugin] wildfire)
" rv: range view
" rvc: range view cancel
map <Leader>rv <Plug>(wildfire-fuel)
map <Leader>rvc <Plug>(wildfire-water)
let g:wildfire_objects=["i'",'i"',"i)","i]","i}","i>","ip"]

"=======================
"|                     |
"|   代码编写:C/C++    |
"|                     |
"=======================

" [Plugin]a.vim: 切换实现和接口文件
nmap <Leader>ch :A<CR>
nmap <Leader>sch :AS<CR>

" 根据声明补全定义模板 ([plugin]protodef)
" 设置 pullproto.pl 脚本路径
let g:protodefprotogetter='~/.vim/bundle/protodef/pullproto.pl'
" 成员函数的实现顺序与声明顺序一致
let g:disable_protodef_sorting=1

"=======================
"|                     |
"|   代码编写:Python   |
"|                     |
"=======================

" PEP8_检查([Plugin] flake8)
autocmd FileType python map <leader>pf :call Flake8()<CR>
autocmd BufWritePost *.py call Flake8()
let g:flake8_show_in_gutter=1
let g:flake8_show_quickfix=0

"python virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

"=======================
"|                     |
"|      辅助功能       |
"|                     |
"=======================

"" 中文输入
let g:vimim_cloud='sogou.dynamic'
let g:vimim_map='c-bslash'

"=======================
"|                     |
"|      插件管理       |
"|                     |
"=======================
""vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

""" 外观
Plugin 'altercation/vim-colors-solarized'
Plugin 'Lokaltog/vim-powerline'
Plugin 'nathanaelkane/vim-indent-guides'  "提示缩进
""" 通用编辑
" 代码补全
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'           " 模板补全
Plugin 'CrowsT/vim-snippets'        " 自定义模板
Plugin 'gcmt/wildfire.vim'          " 结对符号补全
Plugin 'vimprj'                     " indexer的依赖插件
Plugin 'DfrankUtil'                 " indexer的依赖插件
Plugin 'indexer.tar.gz'             " 自动生成tags
" 代码编辑辅助
Plugin 'scrooloose/syntastic'       " 静态代码检查
Plugin 'kshenoy/vim-signature'      " 代码书签
Plugin 'scrooloose/nerdcommenter'   " 开关注释
Plugin 'DrawIt'                     " 绘制注释
Plugin 'sjl/gundo.vim'              " 分支撤回工具
Plugin 'easymotion/vim-easymotion'  " 快速跳转
""" 代码查看
Plugin 'scrooloose/nerdtree'    " 文件列表
Plugin 'majutsushi/tagbar'      " 标签列表
Plugin 'fholgado/minibufexpl.vim'
Plugin 'dyng/ctrlsf.vim'        " 工程内搜索
Plugin 'kien/ctrlp.vim'         " 工程内搜索文件
""" 特定编程语言
" C/C++
Plugin 'a.vim'      " 切换实现和声明
Plugin 'STL-Syntax' " STL代码提示
" python
Plugin 'nvie/vim-flake8'   " PEP8代码风格检查
" Markdown
Plugin 'suan/vim-instant-markdown'
" Javascript
Plugin 'ternjs/tern_for_vim'
""" 辅助功能
Plugin 'vim-scripts/VimIM'   " 中文输入

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

