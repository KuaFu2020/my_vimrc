set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'



set tags=./tags;,tags

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cscope setting

if has("cscope")
	set csprg=/usr/bin/cscope              "指定用来执行 cscope 的命令
	set csto=1                             "先搜索tags标签文件，再搜索cscope数据库
	set cst                                "使用|:cstag|(:cs find g)，而不是缺省的:tag
	set nocsverb                           "不显示添加数据库是否成功
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
		"else search cscope.out elsewhere
	else
		let cscope_file=findfile("cscope.out", ".;")
		let cscope_pre=matchstr(cscope_file, ".*/")
		if !empty(cscope_file) && filereadable(cscope_file)
			exe "cs add" cscope_file cscope_pre
		endif
	endif


	set csverb                             "显示添加成功与否
endif

:set cscopequickfix=s-,c-,d-,i-,t-,e-

"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"F5 
nmap <silent> <F5> :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F6> :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <silent> <F7> :cs find c <C-R>=expand("<cword>")<CR><CR>

Plugin 'majutsushi/tagbar' "Tag bar"

"Tagbar
let g:tagbar_width=25
autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()

Plugin 'scrooloose/nerdtree'

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeWinSize=30
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=1

Plugin 'dense-analysis/ale'

"ale
"始终开启标志列
let g:ale_sign_column_always = 1
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''


Plugin 'Valloric/YouCompleteMe'

Plugin 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
