"==============================================================================
"设置leader
"==============================================================================

let mapleader = "\<Space>"
"let g:mapleader = "\<Space>"

"创建新文件
nnoremap <Leader>o :CtrlP<CR>
"保存文件
nnoremap <Leader>w :w<CR>

set modifiable
"------------------------------------------- begin of configs --------------------------------------------


"################### 包依赖 #####################
"package dependence: ctags
"python dependence: pep8, pyflake


" 设置窗口大小
if (has('gui'))
    set lines=50
    set columns=160
endif

" 使光标一直显示在屏幕中间
set so=999

set t_Co=256
set background=dark

set encoding=utf-8

set fileencoding=utf-8

set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1

" 文件格式，默认 ffs=dos,unix
set fileformat=unix                                   "设置新（当前）文件的<EOL>格式，可以更改，如：dos（windows系统常用）
set fileformats=unix,dos,mac                          "给出文件的<EOL>格式类型

set hidden
set guifontset=                                       "此值为空时才可以分别设置中英文字体
set guifont=Inziu\ Iosevka\ SC:h14                "设置英文字体，下面一行是中文字体
set guifontwide=Inziu\ Iosevka\ SC:h14                 "设置字体:字号（字体名称空格用下划线代替）

"==========================================
" 插件管理
"==========================================

"if empty(glob('~/vimfiles/autoload/plug.vim'))
"  silent !powershell -executionpolicy Unrestricted curl 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' -outfile "vimfiles/autoload/plug.vim"
"  autocmd VimEnter * PlugInstall | source $MYVIMRC
"endif

" macos
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"setup & neobundle {{{
"if 0 | endif

"if &compatible
"    set nocompatible    " Be Improved
"endif

" Required:
"set runtimepath+=~/vimfiles/bundle/neobundle.vim/

"Required:
"call neobundle#begin(expand('~/vimfiles/bundle/'))

call plug#begin('~/vimfiles/bundle')

Plug 'junegunn/vim-plug'

" Let NeoBundle manage NeoBundle
" Required
"NeoBundleFetch 'Shougo/neobundle.vim'

Plug 'molisiye/vimrc'
" ################### 基础 ######################

" 多语言语法检查
Plug 'scrooloose/syntastic'
let g:syntastic_check_on_open = 1
let g:syntastic_cpp_include_dirs = ['C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include']
"let g:syntastic_cpp_checkers = ['clang_check']
"let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_enable_signs=1
"let g:syntastic_quiet_warnings=1
let g:syntastic_cpp_compiler = 'clang++'
"let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
"set error or warning signs
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
"whether to show balloons
"let g:syntastic_enable_balloons = 1
let g:syntastic_error_symbol='>>'
let g:syntastic_warning_symbol='>'
let g:syntastic_check_on_wq=0
let g:syntastic_enable_highlighting=1

" 最轻量
" let g:syntastic_python_checkers=['pyflakes'] " 使用pyflakes

" 中等
" error code: http://pep8.readthedocs.org/en/latest/intro.html#error-codes
let g:syntastic_python_checkers=['pyflakes', 'pep8'] " 使用pyflakes,速度比pylint快
let g:syntastic_python_pep8_args='--ignore=E501,E225,E124,E712'

" 重量级, 但是足够强大, 定制完成后相当个性化
" pylint codes: http://pylint-messages.wikidot.com/all-codes
" let g:syntastic_python_checkers=['pyflakes', 'pylint'] " 使用pyflakes,速度比pylint快
" let g:syntastic_python_checkers=['pylint'] " 使用pyflakes,速度比pylint快
" let g:syntastic_python_pylint_args='--disable=C0111,R0903,C0301'


let g:syntastic_javascript_checkers = ['jsl', 'jshint']
let g:syntastic_html_checkers=['tidy', 'jshint']
" 修改高亮的背景色, 适应主题
highlight SyntasticErrorSign guifg=white guibg=black

" to see error location list
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_loc_list_height = 5

function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic error location panel
        Errors
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>
" nnoremap <Leader>sn :lnext<cr>
" nnoremap <Leader>sp :lprevious<cr>

" ################### 自动补全 ###################

" 代码自动补全
"迄今为止用到的最好的自动VIM自动补全插件
"重启 :YcmRestartServer
"Plug 'Valloric/YouCompleteMe'

"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
"let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
"let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
"let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_tags_files = 1

"let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开

" 跳转到定义处, 分屏打开
"let g:ycm_goto_buffer_command = 'horizontal-split'
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
" old version
"if !empty(glob("~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"))
"    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/cpp/ycm/.ycm_extra_conf.py"
"endif
"
" new version
"if !empty(glob("~/vimfiles/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
"    let g:ycm_global_ycm_extra_conf = "~/vimfiles/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
"endif

" 直接触发自动补全 insert模式下
"let g:ycm_key_invoke_completion = '<C-Space>'
" 黑名单,不启用
"let g:ycm_filetype_blacklist = {
"      \ 'tagbar' : 1,
"      \ 'gitcommit' : 1,
"      \}

"neocomplete
Plug 'Shougo/neocomplete.vim'
"let g:neocomplete#enable_at_startup = 1
"let g:acp_enableAtStartup = 0
"let g:neocomplete#enable_smart_case = 1

" 代码片段快速插入 (snippets中,是代码片段资源,需要学习)
"Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

"let g:UltiSnipsExpandTrigger       = "<tab>"
"let g:UltiSnipsJumpForwardTrigger  = "<tab>"
"let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
"if g:iswindows
"	let g:UltiSnipsSnippetsDir = '~/vimfiles/UltiSnips'
"elseif
"	let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
"endif
" 定义存放代码片段的文件夹 UltiSnips下，使用自定义和默认的，将会的到全局，有冲突的会提示
" 进入对应filetype的snippets进行编辑
"map <leader>us :UltiSnipsEdit<CR>

" ctrl+j/k 进行选择
func! g:JInYCM()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<c-j>"
    endif
endfunction

func! g:KInYCM()
    if pumvisible()
        return "\<C-p>"
    else
        return "\<c-k>"
    endif
endfunction
inoremap <c-j> <c-r>=g:JInYCM()<cr>
au BufEnter,BufRead * exec "inoremap <silent> " . g:UltiSnipsJumpBackwordTrigger . " <C-R>=g:KInYCM()<cr>"
let g:UltiSnipsJumpBackwordTrigger = "<c-k>"

Plug 'Yggdroot/indentLine'

"################### 快速编码  ###################

" 快速注释
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1

" 快速加入环绕字符
Plug 'tpope/vim-surround'
" for repeat -> enhance surround.vim, . to repeat command
Plug 'tpope/vim-repeat'

" 快速去除行尾空格 [<leader> + <Space>]
Plug 'bronson/vim-trailing-whitespace'
map <leader><space> :FixWhitespace<cr>

" 快速赋值语句对齐
Plug 'junegunn/vim-easy-align'
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

" auto pairs
Plug 'jiangmiao/auto-pairs'

"################### 快速移动 ###################

"更高效的移动 [,, + w/fx]
Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_smartcase = 1
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" 重复上一次操作, 类似repeat插件, 很强大
map <Leader><leader>. <Plug>(easymotion-repeat)

Plug 'vim-scripts/matchit.zip'

" 显示marks - 方便自己进行标记和跳转
" m[a-zA-Z] add mark
" '[a-zA-Z] go to mark
" m<Space> del all marks
Plug 'kshenoy/vim-signature'


"################### 快速选中 ###################

" 选中区块
Plug 'terryma/vim-expand-region'
"map + <Plug>(expand_region_expand)
"map _ <Plug>(expand_region_shrink)
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

" 多光标选中编辑
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-m>'
"let g:multi_cursor_start_key='g<C-n>'
"let g:multi_cursor_start_word_key='<C-n>'
"let g:multi_cursor_prev_key='<C-p>'
"let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"################### 功能相关 ###################

" unite.vim
Plug 'Shougo/unite.vim'
nnoremap <C-p> :Unite file_rec/async<cr>
nnoremap <Leader>f :Unite file<CR>

" vimproc.vim
Plug 'Shougo/vimproc.vim',{
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" 文件搜索
" change to https://github.com/ctrlpvim/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1
" 如果安装了ag, 使用ag
" if executable('ag')
  " " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  " " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
" endif

" ctrlp插件1 - 不用ctag进行函数快速跳转
Plug 'tacahiroy/ctrlp-funky'
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']

" 类似sublimetext的搜索
Plug 'dyng/ctrlsf.vim'
" In CtrlSF window:
" 回车/o, 打开
" t       在tab中打开(建议)
" T - Lkie t but focus CtrlSF window instead of opened new tab.
" q - Quit CtrlSF window.
nmap \ <Plug>CtrlSFCwordPath<CR>
" let g:ctrlsf_position = 'below'
" let g:ctrlsf_winsize = '30%'
let g:ctrlsf_auto_close = 0
let g:ctrlsf_confirm_save = 0
" Note: cannot use <CR> or <C-m> for open
" Use : <sapce> or <tab>
let g:ctrlsf_mapping = {
    \ "open"  : "<Space>",
    \ "openb" : "O",
    \ "tab"   : "t",
    \ "tabb"  : "T",
    \ "prevw" : "p",
    \ "quit"  : "q",
    \ "next"  : "<C-J>",
    \ "prev"  : "<C-K>",
    \ "pquit" : "q",
    \ }

" git. git操作还是习惯命令行，vim里面处理简单diff编辑操作
Plug 'tpope/vim-fugitive'
":Gdiff :Gstatus :Gvsplit
nnoremap <leader>ge :Gdiff<CR>
" not ready to open
" <leader>gb maps to :Gblame<CR>
" <leader>gs maps to :Gstatus<CR>
" <leader>gd maps to :Gdiff<CR>  和现有冲突
" <leader>gl maps to :Glog<CR>
" <leader>gc maps to :Gcommit<CR>
" <leader>gp maps to :Git push<CR>

" 同git diff，实时展开文件中修改的行
" 只是不喜欢除了行号多一列，默认关闭，gs时打开
"Plug 'airblade/vim-gitgutter'
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1
nnoremap <leader>gs :GitGutterToggle<CR>

" edit history, 可以查看回到某个历史状态
Plug 'sjl/gundo.vim'
nnoremap <leader>h :GundoToggle<CR>

"################### 显示增强 ###################

" 状态栏增强功能显示
" 新的airline配置
Plug 'bling/vim-airline'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" 是否打开tabline
"let g:airline#extensions#tabline#enabled = 1


" 括号显示增强
Plug 'kien/rainbow_parentheses.vim'
" 不加入这行, 防止黑色括号出现, 很难识别
" \ ['black',       'SeaGreen3'],
"let g:rbpt_colorpairs = [
"	\ ['brown', 'RoyalBlue3'],
"	\ ['Darkblue', 'SeaGreen3'],
"	\ ['darkgray', 'DarkOrchid3'],
"	\ ['darkgreen', 'firebrick3'],
"	\ ['darkcyan', 'RoyalBlue3'],
"	\ ['darkred', 'SeaGreen3'],
"	\ ['darkmagenta', 'DarkOrchid3'],
"	\ ['brown', 'firebrick3'],
"	\ ['gray', 'RoyalBlue3'],
"	\ ['darkmagenta', 'DarkOrchid3'],
"	\ ['Darkblue', 'firebrick3'],
"	\ ['darkgreen', 'RoyalBlue3'],
"	\ ['darkcyan', 'SeaGreen3'],
"	\ ['darkred', 'DarkOrchid3'],
"	\ ['red', 'firebrick3'],
"	\ ]

"let g:rbpt_max = 16
"let g:rbpt_loadcmd_toggle = 0
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
let g:rainbow_conf = {
	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
	\	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
	\	'operators': '_,_',
	\	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
	\	'separately': {
	\		'*': {},
	\		'tex': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
	\		},
	\		'lisp': {
	\			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
	\		},
	\		'vim': {
	\			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
	\		},
	\		'html': {
	\			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
	\		},
	\		'css': 0,
	\	}
	\}

"################### 显示增强 - 主题 ###################"

" 主题 solarized
Plug 'altercation/vim-colors-solarized'
"let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"


"################### 快速导航 ###################

" 目录导航
Plug 'scrooloose/nerdtree'
map <leader>n :NERDTreeToggle<CR>
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
"let NERDTreeDirArrows=0
"let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
" s/v 分屏打开文件
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'

Plug 'jistr/vim-nerdtree-tabs'
map <Leader>n <plug>NERDTreeTabsToggle<CR>
" 关闭同步
let g:nerdtree_tabs_synchronize_view=0
let g:nerdtree_tabs_synchronize_focus=0
" 自动开启nerdtree
"let g:nerdtree_tabs_open_on_console_startup=1

" Vim Workspace Controller
Plug 'szw/vim-ctrlspace'
let g:airline_exclude_preview = 1
hi CtrlSpaceSelected guifg=#586e75 guibg=#eee8d5 guisp=#839496 gui=reverse,bold ctermfg=10 ctermbg=7 cterm=reverse,bold
hi CtrlSpaceNormal guifg=#839496 guibg=#021B25 guisp=#839496 gui=NONE ctermfg=12 ctermbg=0 cterm=NONE
hi CtrlSpaceSearch guifg=#cb4b16 guibg=NONE gui=bold ctermfg=9 ctermbg=NONE term=bold cterm=bold
hi CtrlSpaceStatus guifg=#839496 guibg=#002b36 gui=reverse term=reverse cterm=reverse ctermfg=12 ctermbg=8


" 标签导航
Plug 'majutsushi/tagbar'
nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1


"################### 语言相关 ###################

" c/cpp头文件和源文件切换
Plug 'taxilian/a.vim'

Plug 'thinca/vim-quickrun'
let g:quickrun_config = {
\   "_" : {
\       "outputter" : "message",
\   },
\}

let g:quickrun_no_default_key_mappings = 1
nmap <Leader>r <Plug>(quickrun)
map <F10> :QuickRun<CR>

"###### C# #############
Plug 'OrangeT/vim-csharp'

"###### Python #########
" python fly check, 弥补syntastic只能打开和保存才检查语法的不足
Plug 'kevinw/pyflakes-vim'
let g:pyflakes_use_quickfix = 0

" for python.vim syntax highlight
Plug 'hdima/python-syntax'
let python_highlight_all = 1


"###### Markdown #########
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled=1

"###### HTML/JS/JQUERY/CSS #########
" for javascript 注意：syntax这个插件要放在前面
"Plug 'jelera/vim-javascript-syntax'
"Plug 'pangloss/vim-javascript'
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


"######## org-mode #######
"Plug 'jceb/vim-orgmode'

call plug#end()

silent! colorscheme solarized

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline

" 修复ctrl+m 多光标操作选择的bug，但是改变了ctrl+v进行字符选中时将包含光标下的字符
"set selection=exclusive
set selection=inclusive
"set selectmode=mouse,key

" 相对行号      行号变成相对，可以用 nj  nk   进行跳转 5j   5k 上下跳5行
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
"nnoremap <C-n> :call NumberToggle()<cr>

"===============================
"       自定义快捷键
"===============================


" 命令行模式增强，ctrl - a到行首， -e 到行尾
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" --------tab/buffer相关

"Use arrow key to change buffer"
" TODO: 如何跳转到确定的buffer?
" :b1 :b2   :bf :bl
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
noremap <left> :bp<CR>
noremap <right> :bn<CR>


" tab 操作
" TODO: ctrl + n 变成切换tab的方法
" http://vim.wikia.com/wiki/Alternative_tab_navigation
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
"map <C-2> 2gt
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <leader>tj :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>


" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>
" TODO: 配置成功这里, 切换更方便, 两个键
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i
" nnoremap <C-Left> :tabprevious<CR>
" nnoremap <C-Right> :tabnext<CR>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" select all
map <Leader>sa ggVG"

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" 分屏窗口移动
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
"------------------------------------------- end of configs --------------------------------------------
