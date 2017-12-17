" Version: 0.1
" =====================================

if exists("g:loaded_vimrc") || &cp
    finish
else
    let g:loaded_vimrc = 1
endif

" =============================================================================
"        << 判断操作系统是 Windows 还是 Linux 和判断是终端还是 Gvim >>
" =============================================================================
let g:iswindows = 0
let g:islinux = 0

" -----------------------------------------------------------------------------
"  < 判断操作系统是否是 Windows 还是 Linux >
" -----------------------------------------------------------------------------

if(has("win32") || has("win64") || has("win16"))
    let g:iswindows = 1
else
    let g:islinux = 1
endif

" -----------------------------------------------------------------------------
"  < 判断是终端还是 Gvim >
" -----------------------------------------------------------------------------
if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif


" =============================================================================
"                          << 以下为软件默认配置 >>
" =============================================================================

" -----------------------------------------------------------------------------
"  < Windows Gvim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if (g:iswindows && g:isGUI)
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

if (g:iswindows && g:isGUI)
    "解决菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim

    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

" -----------------------------------------------------------------------------
"  < Linux Gvim/Vim 默认配置> 做了一点修改
" -----------------------------------------------------------------------------
if g:islinux
	set hlsearch        "高亮搜索
	set incsearch       "在输入要搜索的文字时，实时匹配
endif

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if g:isGUI
    " S ource a global configuration file if available
    if filereadable("/etc/vim/gvimrc.local")
        source /etc/vim/gvimrc.local
    endif
else
    " T his line should not be removed as it ensures that various options are
    " properly set to work with the Vim-related packages available in Debian.
    runtime! debian.vim

    " Vim5 and later versions support syntax highlighting. Uncommenting the next
    " line enables syntax highlighting by default.
    if has("syntax")
        syntax on
    endif

    set mouse=a                    " 在任何模式下启用鼠标
    set t_Co=256                   " 在终端启用256色
    set backspace=2                " 设置退格键可用

    " Source a global configuration file if available
    if filereadable("/etc/vim/vimrc.local")
        source /etc/vim/vimrc.local
    endif
endif


" =============================================================================
"                          << 以下为用户自定义配置 >>
" =============================================================================

if has('persistent_undo')
    set undolevels=1000     " How many undos
    set undoreload=10000    " number of lines to save for undo
    set undofile            " So is persistent undo ...
    set undodir=~/vimfiles/vimundo/
endif

" -----------------------------------------------------------------------------
"  < 编码配置 >
" -----------------------------------------------------------------------------

"v7.4 patch393引入的,解决Windows Vista以上的版本多字节字符显示不正确的问题,可以选择将渲染方式从默认的GDI改为DirectWrite
"参考文档:
"http://hail2u.net/blog/software/vim-renderoptions-option.html
"http://usevim.com/2014/08/06/windows-font-rendering/
if has('win32') || has('win64')
    if (v:version == 704 && has("patch393")) || v:version > 704
        set renderoptions=type:directx,level:0.50,
                    \gamma:1.0,contrast:0.0,geom:1,renmode:5,taamode:1
    endif
endif
" -----------------------------------------------------------------------------
"  < 编写文件时的配置 >
" -----------------------------------------------------------------------------
filetype on                                           "启用文件类型侦测
filetype plugin on                                    "针对不同的文件类型加载对应的插件
filetype plugin indent on                             "启用缩进

set nocompatible                                      "禁用 Vi 兼容模式
set cindent                                           "使用c/c++的自动缩进格式
"set cinoptions=e0,{0,1s,t0,n-2,p2s,(03s,=.5s,>1s,=1s,:1s     "设置C/C++语言的具体缩进方式
"set smartindent                                       "启用智能对齐方式
set expandtab                                         "将Tab键转换为空格
set tabstop=4                                         "设置Tab键的宽度，可以更改，如：宽度为2
set shiftwidth=4                                      "换行时自动缩进宽度，可更改（宽度同tabstop）
set softtabstop=4
set smarttab                                          "指定按一次backspace就删除shiftwidth宽度
set backspace=indent,eol,start
set foldenable                                        "启用折叠
set foldmethod=indent                                 "indent 折叠方式
" set foldmethod=marker                                "marker 折叠方式
set foldlevel=99

"突出显示当前行等
"set cursorcolumn
set cursorline


" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99
" 代码折叠自定义快捷键
let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun


" 当文件在外部被修改，自动更新该文件
set autoread

" 常规模式下输入 cS 清除行尾空格
nnoremap cS :%s/\s\+$//g<CR>:noh<CR>

" 常规模式下输入 cM 清除行尾 ^M 符号
nnoremap cM :%s/\r$//g<CR>:noh<CR>

set ignorecase                                        "搜索模式里忽略大小写
set smartcase                                         "如果搜索模式包含大写字符，不使用 'ignorecase' 选项，只有在输入搜索模式并且打开 'ignorecase' 选项时才会使用
" set noincsearch                                       "在输入要搜索的文字时，取消实时匹配

" Ctrl + K 插入模式下光标向上移动
inoremap <c-k> <Up>

" Ctrl + J 插入模式下光标向下移动
inoremap <c-j> <Down>

" Ctrl + H 插入模式下光标向左移动
inoremap <c-h> <Left>

" Ctrl + L 插入模式下光标向右移动
inoremap <c-l> <Right>

" 启用每行超过80列的字符提示（字体变蓝并加下划线），不启用就注释掉
au BufWinEnter * let w:m2=matchadd('Underlined', '\%>' . 80 . 'v.\+', -1)

" -----------------------------------------------------------------------------
"  < 界面配置 >
" -----------------------------------------------------------------------------
set number                                            "显示行号
set laststatus=2                                      "启用状态栏信息
set cmdheight=2                                       "设置命令行的高度为2，默认为1
set cursorline                                        "突出显示当前行
set nowrap                                            "设置不自动换行
set shortmess=atI                                     "去掉欢迎界面

" 设置 gVim 窗口初始位置及大小
if g:isGUI
    " au GUIEnter * simalt ~x                         "窗口启动时自动最大化
    winpos 300 10                                     "指定窗口出现的位置，坐标原点在屏幕左上角
    set lines=38 columns=120                          "指定窗口大小，lines为高度，columns为宽度
endif




" 显示/隐藏菜单栏、工具栏、滚动条，可用 Ctrl + F11 切换
if g:isGUI
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    nnoremap <silent> <c-F11> :if &guioptions =~# 'm' <Bar>
        \set guioptions-=m <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=r <Bar>
        \set guioptions-=L <Bar>
    \else <Bar>
        \set guioptions+=m <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=r <Bar>
         \set guioptions+=L <Bar>
     \endif<CR>
endif


" -----------------------------------------------------------------------------
"  < 编译、连接、运行配置 (目前只配置了C、C++、Java语言)>
" -----------------------------------------------------------------------------
" F9 一键保存、编译、连接存并运行
" nmap <F9> :call Run()<CR>
" imap <F9> <ESC>:call Run()<CR>

" " Ctrl + F9 一键保存并编译
" nmap <c-F9> :call Compile()<CR>
" imap <c-F9> <ESC>:call Compile()<CR>

" " Ctrl + F10 一键保存并连接
" nmap <c-F10> :call Link()<CR>
" imap <c-F10> <ESC>:call Link()<CR>

let s:LastShellReturn_C = 0
let s:LastShellReturn_L = 0
let s:ShowWarning = 1
let s:Obj_Extension = '.o'
let s:Exe_Extension = '.exe'
let s:Class_Extension = '.class'
let s:Sou_Error = 0

"let s:windows_CFlags = 'gcc\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:windows_CFlags = 'cl\ %'
let s:linux_CFlags = 'gcc\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:windows_CPPFlags = 'g++\ -fexec-charset=gbk\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'
let s:linux_CPPFlags = 'g++\ -Wall\ -g\ -O0\ -c\ %\ -o\ %<.o'

let s:JavaFlags = 'javac\ %'

"单个文件编译
noremap <F9> :call Do_OneFileMake()<CR>
function! Do_OneFileMake()
	if expand("%:p:h")!=getcwd()
	    echohl WarningMsg | echo "Fail to make! This file is not in the current dir! Press <F7> to redirect to the dir of this file." | echohl None
	    return
	endif

	let sourcefileename=expand("%:t")
	if (sourcefileename=="" || (&filetype!="cpp" && &filetype!="c"))
	    echohl WarningMsg | echo "Fail to make! Please select the right file!" | echohl None
	    return
	endif

	let deletedspacefilename=substitute(sourcefileename,' ','','g')
	if strlen(deletedspacefilename)!=strlen(sourcefileename)
	    echohl WarningMsg | echo "Fail to make! Please delete the spaces in the filename!" | echohl None
	    return
	endif

	if &filetype=="c"
	    if g:iswindows==1
		"set makeprg=gcc\ -o\ %<.exe\ %
		set makeprg=cl\ %
	    else
		set makeprg=gcc\ -o\ %<\ %
	    endif
	elseif &filetype=="cpp"
	    if g:iswindows==1
		"set makeprg=g++\ -o\ %<.exe\ %
		set makeprg=cl\ \/nologo %
	    else
		set makeprg=g++\ -o\ %<\ %
	    endif
	    "elseif &filetype=="cs"
	    "set makeprg=csc\ \/nologo\ \/out:%<.exe\ %
	endif

	if(g:iswindows==1)
	    let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'.exe','g')
	    let toexename=outfilename
	else
	    let outfilename=substitute(sourcefileename,'\(\.[^.]*\)' ,'','g')
	    let toexename=outfilename
	endif

	if filereadable(outfilename)
	    if(g:iswindows==1)
		let outdeletedsuccess=delete(getcwd()."\\".outfilename)
	    else
		let outdeletedsuccess=delete("./".outfilename)
	    endif

	    if(outdeletedsuccess!=0)
		set makeprg=make
		echohl WarningMsg | echo "Fail to make! I cannot delete the ".outfilename | echohl None
		return
	    endif
	endif

	execute "silent make"
	set makeprg=make
	execute "normal :"

	if filereadable(outfilename)
	    if(g:iswindows==1)
		execute "!".toexename
	    else
		execute "!./".toexename
	    endif
	endif

	execute "copen"
endfunction

"进行make的设置
noremap <F6> :call Do_make()<CR>
noremap <c-F6> :silent make clean<CR>

function! Do_make()
    set makeprg=make
    execute "silent make"
    execute "copen"
endfunction

nnoremap  <F10> <ESC>:update<cr>:exec '!python' shellescape(@%, 1)<cr>

"==============================================================================
"                 自定义函数
"==============================================================================
" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call append(0, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call append(0, "\#!/usr/bin/env python")
        call append(1, "\# Filename: ".expand("%:t"))
    endif
endfunc

"用pandoc预览markdown
function! s:PreviewMarkdown()
    " if !executable('pandoc')
        " echohl ErrorMsg | echo 'Please install pandoc first.' | echohl None
        " return
    " endif
    if g:iswindows
        let BROWSER_COMMAND = 'cmd.exe /c start ""'
    elseif g:islinux
        let BROWSER_COMMAND = 'xdg-open'
    elseif g:ismac
        let BROWSER_COMMAND = 'open'
    endif

    let output_file = tempname() . '.html'
    let input_file = tempname() . '.md'
    let css_file = 'file://' . expand($HOME . '/github-markdown.css', 1)
    " Convert buffer to UTF-8 before running pandoc
    let original_encoding = &fileencoding
    let original_bomb = &bomb

    silent! execute 'set fileencoding=utf-8 nobomb'
    " Generate html file for preview
    let content = getline(1, '$')
    let newContent = []
    for line in content
        let str = matchstr(line, '\(!\[.*\](\)\@<=.\+\.\%(png\|jpe\=g\|gif\)')
        if str != "" && match(str, '^https\=:\/\/') == -1
            let newLine = substitute(line, '\(!\[.*\]\)(' . str . ')',
                        \'\1(file://' . escape(expand("%:p:h", 1), '\') .
                        \(s:isWin ? '\\\\' : '/') .
                        \escape(expand(str, 1), '\') . ')', 'g')
        else
            let newLine = line
        endif
        call add(newContent, newLine)
    endfor

    call writefile(newContent, input_file)

    silent! execute '!pandoc -f markdown -t html5 -s -S -c "' . css_file . '" -o "' . output_file .'" "' . input_file . '"'
    call delete(input_file)
    " Change encoding back
    silent! execute 'set fileencoding=' . original_encoding . ' ' . original_bomb
    " Preview
    silent! execute '!' . BROWSER_COMMAND . ' "' . output_file . '"'
    execute input('Press ENTER to continue...')
    echo
    call delete(output_file)
endfunction

nnoremap <silent> <Leader>p :call <SID>PreviewMarkdown()<CR>


" -----------------------------------------------------------------------------
"  < 其它配置 >
" -----------------------------------------------------------------------------
set writebackup                             "保存文件前建立备份，保存成功后删除该备份
set nobackup                                "设置无备份文件
" set noswapfile                              "设置无临时文件
" set vb t_vb=                                "关闭提示音
"vimrc修改后自动加载，windows
if g:iswindows
    autocmd! bufwritepost _vimrc source %
else
    "vimrc修改后自动加载，linux
    autocmd! bufwritepost .vimrc source %
endif

"让vimd的补全菜单行为与一般IDE一致（参考VimTip1228）
set completeopt=longest,menu
