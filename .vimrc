"set t_Co=256

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'. Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set nocompatible

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on            " 语法高亮
endif


"文件编码
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936


" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set ignorecase        " 搜索模式里忽略大小写
set smartcase        " 如果搜索模式包含大写字符，不使用 'ignorecase' 选项。只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用。
set autowrite        " 自动把内容写回文件: 如果文件被修改过，在每个 :next、:rewind、:last、:first、:previous、:stop、:suspend、:tag、:!、:make、CTRL-] 和 CTRL-^命令时进行;用 :buffer、CTRL-O、CTRL-I、'{A-Z0-9} 或 `{A-Z0-9} 命令转到别的文件时亦然。

"默认窗口大小
set lines=35 columns=82
"光标在窗口上下边界时距离边界7行即开始滚屏
set so=7
"显示行号
set number

"set go= "无菜单、工具栏"
" 隐藏工具栏，可用快捷键F2切换
set guioptions-=T


"语法高亮
"syntax=on

"自动缩进
set autoindent
" C语言方式缩进
set cindent
" 智能缩进
set smartindent

" 统一缩进为4
set tabstop=4        " 设置制表符(tab键)的宽度
set softtabstop=4     " 设置软制表符的宽度
set shiftwidth=4    " (自动) 缩进使用的4个空格

set cindent            " 使用 C/C++ 语言的自动缩进方式
set modeline

" 空格代替tab
set expandtab


" 侦测文件类型
filetype on

" 为特定文件类型载入相关缩进格式
filetype indent on

" 为特定的文件类型载入对应的插件
filetype plugin on
filetype plugin indent on

" 不与vi兼容
set nocp


au Filetype make set noexpandtab

au FileType c,cpp,h,java,javascript,html,htmldjango setlocal cindent

" 使用C样式的缩进
function! GnuIndent()
    setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
    setlocal shiftwidth=4
    setlocal tabstop=4
endfunction

"astyle as c and cpp styler
autocmd FileType c,cpp,h set formatprg=astyle

au FileType c,cpp,h,java,python,javascript setlocal cinoptions=:0,g0,(0,w1 shiftwidth=4 tabstop=4 softtabstop=4
au FileType diff  setlocal shiftwidth=4 tabstop=4
au FileType html,css,htmldjango,html,xml setlocal autoindent sw=2 ts=2 sts=2 fdm=manual expandtab
au FileType javascript setlocal sw=4 ts=4 sts=4 expandtab
au FileType changelog setlocal textwidth=76

set shiftwidth=4
set tabstop=4
set softtabstop=4

" 自动换行
set wrap

" 整词换行
set linebreak


" 高亮显示匹配的括号
set showmatch

" 搜索逐字符高亮和实时搜索
set hlsearch
set incsearch

set showmatch        " 设置匹配模式，显示匹配的括号
set linebreak        " 整词换行
set wrap             " 自动换行显示
set whichwrap=b,s,<,>,[,] " 光标从行首和行末时可以跳到另一行去
"set hidden " Hide buffers when they are abandoned
set history=50        " set command history to 50    "历史记录50条
"鼠标支持
if has('mouse')
    set mouse=a
    "set selection=exclusive
    set selectmode=mouse,key
    set nomousehide
endif

"--状态行设置--
set laststatus=2 " 总显示最后一个窗口的状态行；设为1则窗口数多于一个的时候显示最后一个窗口的状态行；0不显示最后一个窗口的状态行
set ruler            " 标尺，用于显示光标位置的行号和列号，逗号分隔。每个窗口都有自己的标尺。如果窗口有状态行，标尺在那里显示。否则，它显示在屏幕的最后一行上。

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White

"--命令行设置--
set showcmd            " 命令行显示输入的命令
set showmode        " 命令行显示vim当前模式
set cmdheight=1             " 设定命令行的行数为 1


" 编码设置
if has("gui_running") || has("unix")
	set encoding=utf-8 " 设置vim内部使用的字符编码
	lang messages zh_CN.UTF-8 " 解决consle输出乱码
else
	set encoding=chinese " 设置命令提示符下vim不乱码
	set termencoding=chinese "终端下的编码，对gvim来说没有必要设置
endif
" 在图形界面和终端的配色方案、字体
if has("gui_running")
	set columns=100 lines=40    "设置gui默认界面大小
	if has("unix")
		colorscheme desert
		set guifont=Bitstream\ Vera\ Sans\ Mono\ 13
	"	set guifont=Monospace\ 13
		set guifontwide=KaiTi\ 13
	elseif has("win32")
		colorscheme asu1dark
		set guifont=Courier:h12:cANSI
		set guifontwide=NSimSun:h12
" guifontwide只有在encoding=utf-8时才生效
	endif
else
	if has("unix")
		colorscheme default
	elseif
		has("win32")
		colorscheme ir_black
	endif
endif


" Recognize standard C++ headers
au BufEnter /usr/include/c++/*    setf cpp
au BufEnter /usr/include/g++-3/*  setf cpp

" Setting for files following the GNU coding standard
au BufEnter /usr/*                call GnuIndent()

function! RemoveTrailingSpace()
    if $VIM_HATE_SPACE_ERRORS != '0' &&
                \(&filetype == 'c' || &filetype == 'cpp' || &filetype == 'vim')
        normal m`
        silent! :%s/\s\+$//e
        normal ``
    endif
endfunction
" Remove trailing spaces for C/C++ and Vim files
au BufWritePre *                  call RemoveTrailingSpace()


"默认无备份
set nobackup
set nowritebackup

"在insert模式下能用删除键进行删除
set backspace=indent,eol,start

"去掉有关vi一致性模式，避免以前版本的一些bug和局限
set nocp
" 增强模式中的命令行自动完成操作
set wildmenu

" 使用英文菜单,工具条及消息提示
set langmenu=none

"自动缩排
set ai

" 不要闪烁
set novisualbell

"设置语法折叠
set foldmethod=syntax
set foldcolumn=0 "设置折叠区域的宽度
set foldlevel=100
" 用空格键来开关折叠
set foldenable
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
set foldlevel=100


"添加python，shell文件头
au BufNewFile *.py call ScriptHeader()
au BufNewFile *.sh call ScriptHeader()

function ScriptHeader()
    if &filetype == 'python'
        let header = "#!/usr/bin/env python2"
        let coding = "# -*- coding:utf-8 -*-"
        let cfg = "# vim: ts=4 sw=4 sts=4 expandtab"
    elseif &filetype == 'sh'
        let header = "#!/bin/bash"
    endif
    let line = getline(1)
    if line == header
        return
    endif
    normal m'
    call append(0,header)
    if &filetype == 'python'
        call append(1,coding)
        call append(3, cfg)
    endif
    normal ''
endfunction

"插件管理vundlel
set nocompatible " be iMproved
filetype off " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'Tagbar'
"Bundle 'cscope'
Bundle 'OmniCppComplete'
Bundle 'scrooloose/nerdtree'
Bundle 'snipMate'
Bundle 'DoxygenToolkit.vim'

filetype plugin indent on

"tagbar配置
nmap <silent> <F4> :TagbarToggle<CR>
    let g:tagbar_ctags_bin = 'ctags'
    let g:tagbar_width = 25

"nerdtree配置,详细配置可参考github上的代码仓库
map <F3> :NERDTreeToggle<CR>

"omniCpp配置
let OmniCpp_GlobalScopeSearch = 1 "0 or 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1
imap <TAB> <C-X><C-N>






"tag,cscope配置
let g:vimrc_iswindows=0
let g:iswindows=0
map <F12> :call Do_CsTag()<CR>
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>:copen<CR>
nmap <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>:copen<CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>:copen<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>:copen<CR>
function Do_CsTag()
    let dir = getcwd()
    if filereadable("tags")
        if(g:iswindows==1)
            let tagsdeleted=delete(dir."\\"."tags")
        else
            let tagsdeleted=delete("./"."tags")
        endif
        if(tagsdeleted!=0)
            echohl WarningMsg | echo "Fail to do tags! I cannot delete the tags" | echohl None
            return
        endif
    endif
    if has("cscope")
        silent! execute "cs kill -1"
    endif
    if filereadable("cscope.files")
        if(g:iswindows==1)
            let csfilesdeleted=delete(dir."\\"."cscope.files")
        else
            let csfilesdeleted=delete("./"."cscope.files")
        endif
        if(csfilesdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.files" | echohl None
            return
        endif
    endif
    if filereadable("cscope.out")
        if(g:iswindows==1)
            let csoutdeleted=delete(dir."\\"."cscope.out")
        else
            let csoutdeleted=delete("./"."cscope.out")
        endif
        if(csoutdeleted!=0)
            echohl WarningMsg | echo "Fail to do cscope! I cannot delete the cscope.out" | echohl None
            return
        endif
    endif
    if(executable('ctags'))
        "silent! execute "!ctags -R --c-types=+p --fields=+S *"
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q ."
    endif
    if(executable('cscope') && has("cscope") )
        if(g:iswindows!=1)
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.cs' > cscope.files"
        else
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.java,*.cs >> cscope.files"
        endif
        silent! execute "!cscope -b"
        execute "normal :"
        if filereadable("cscope.out")
            execute "cs add cscope.out"
        endif
    endif
endfunction

"doxygen tool kit
let g:DoxygenToolkit_briefTag_pre="@bref  "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag="@returns   "
"let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
"let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="li shuangjiang"
"let g:DoxygenToolkit_licenseTag="Copyright 2010, Kunihiko Sadakane, all rights reserved.\n  This software may be used freely for any purpose. \nNo warranty is given regarding the quality of this software."
