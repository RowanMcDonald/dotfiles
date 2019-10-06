"============================================================================
" NEOVIM config of Rowan McDonald // heavily cargo culted
"============================================================================

"=========================
" PLUGINS (using vim-plug)
"=========================

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-endwise'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
" Plug 'dbakker/vim-projectroot'
" Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-vinegar' " netrw+
Plug 'arthurxavierx/vim-caser' " change casing

Plug 'tpope/vim-surround'
" Plug 'tpope/vim-dispatch'
" Plug 'w0rp/ale'

" integrations
Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb' " Enables :Gbrowse
Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim'

" look and feel
Plug 'junegunn/goyo.vim'
Plug 'sleep/limelight.vim'
Plug 'joshdick/onedark.vim'
" Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim' " status line

" snippits
" Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug 'honza/vim-snippets'

" Ruby Support
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
" Plug 'danchoi/ri.vim', { 'for': 'ruby' }
Plug 'nelstrom/vim-textobj-rubyblock'
 Plug 'kana/vim-textobj-user'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'vim-scripts/blockle.vim' " allows for toggling between blocks <Leader>b
Plug 'ngmy/vim-rubocop'

" other languages
Plug 'rust-lang/rust.vim'

" Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

" Plug 'Quramy/tsuquyomi' -- needs vim proc
Plug 'leafgarland/typescript-vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'json', 'typescript'] }

Plug 'janko-m/vim-test' " language agnostic test running
Plug 'jamestthompson3/vim-jest'

" Text obj
Plug 'glts/vim-textobj-comment'
 " Plug 'kana/vim-textobj-user' required above

call plug#end()

""======================
" General vim settings
""======================

filetype plugin indent on
set nocompatible " required by at least vim-textobj-rubyblock
runtime macros/matchit.vim "use `%` to navigate between do ... end

set clipboard=unnamed
set lazyredraw                        " Reduce the redraw frequency
set ruler               " Show the line and column numbers of the cursor.
set formatoptions+=o    " Continue comment marker in new lines.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set showcmd                     " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set autowrite                   " Automatically save before :next, :make etc.
set laststatus=2
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set matchtime=1									" Match tenths of a second
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

set tabstop=2
set shiftwidth=2
set expandtab
let mapleader = "\<SPACE>"

set relativenumber
set numberwidth=3
set nohlsearch
set incsearch
set notermguicolors
set splitbelow splitright
set backspace=indent,eol,start
set undodir=~/.config/nvim/undodir
set directory=~/.config/nvim/tmp,.

""======================
" Wildmenu settings
""======================
set wildmenu
set wildmode=longest:full,full
set wildignore+=*.a,*.o
set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
set wildignore+=.DS_Store,.git,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildignore+=node_modules/*,bower_components/*

"=========================
" Macros
"=========================

"=========================
" Plugin dependecies
"=========================
let g:python_host_prog = '~/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'

"=========================
" Completion
"=========================
let g:SuperTabDefaultCompletionType    = '<C-n>'
let g:SuperTabCrMapping                = 0

"=========================
" Goyo
"=========================

let g:goyo_width=150

function! s:goyo_enter()
				if has('gui_running')
				  set fullscreen
				endif
				Limelight
				let b:quitting = 0
				let b:quitting_bang = 0
				autocmd QuitPre <buffer> let b:quitting = 1
				cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
				Limelight!
				if has('gui_running')
								set nofullscreen
				endif

				" Quit Vim if this is the only remaining buffer
				if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
								if b:quitting_bang
												qa!
								else
												qa
								endif
				endif
				call s:set_highlights()
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


autocmd VimEnter * call s:set_highlights() " this is so goyo doesn't look horrible with iterm coloring
fun! s:set_highlights()
				hi MatchParen term=underline ctermbg=None cterm=underline gui=underline
				highlight CursorLineNr ctermfg=darkgray
				highlight LineNr ctermfg=darkgray
				highlight Pmenu ctermfg=NONE ctermbg=237
endfun

"==================
" Limelight
"==================

let g:limelight_priority = 10
let g:limelight_conceal_ctermfg =60
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

"========================
" ctrl_p
"========================
" https://www.reddit.com/r/vim/comments/83h31q/speed_up_ctrlp_with_fd/
" let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
" let g:ctrlp_custom_ignore = {
" 												\ 'dir':  '\.git$|vcr\|vendor\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|log\|tmp$',
" 												\ 'file': '\.exe$\|\.so$\|\.dat$'
" 												\ }
" let g:ctrlp_root_markers = ['Gemfile', 'package.json']
" let g:ctrlp_working_path_mode = 'r'
" let g:ctrlp_use_caching = 0
" let g:ctrlp_show_hidden = 1


"========================
" Lightline
"========================
" hides --insert--
autocmd VimEnter * call lightline#enable()
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'filetype' ], [ 'fileformat' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"==========================
" Thesaurus backends
"==========================
" let g:tq_mthesaur_file="~/.config/nvim/thesaurus/mthesaur.txt"
" let g:tq_enabled_backends=["thesaurus_com", "mthesaur_txt", "datamuse_com",]
" let g:tq_online_backends_timeout = 0.6

"==========================
" Easy Align
"==========================
" Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)

"==========================
" Make splits easier
"==========================
map <C-J> <C-W><C-J>
map <C-K> <C-W><C-K>
map <C-L> <C-W><C-L>
map <C-H> <C-W><C-H>

"=========================
" Make commands faster
"=========================
nmap ; :

" fix ambiguity around :E<enter>
command! -nargs=* -bar -bang -count=0 -complete=dir E Explore <args>

"=========================
" Saving
"=========================
autocmd BufWritePre *.rb :%s/\s\+$//e

imap <C-S> <Esc>:w<CR>a

"=========================
" Netrw
"=========================
" let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_preview = 1 " sets preview window vertical
let g:netrw_alto = 0
let g:netrw_winsize = 40



"=========================
" vim test
"=========================
nmap <silent> <Leader>n :TestNearest<CR>
nmap <silent> <Leader>f :TestFile<CR>
nmap <silent> <Leader>s :TestSuite<CR>
nmap <silent> <Leader>l :TestLast<CR>
nmap <silent> <Leader>v :TestVisit<CR>

" let test#ruby#use_binstubs = 0
" let test#ruby#bundle_exec = 1
" let g:rspec_command = "!clear; ( cd $(find `( SPEC='{spec}'; CP=${SPEC\\%/*}; while [ -n \"$CP\" ] ; do echo $CP; CP=${CP\\%/*}; done; echo / ) ` -mindepth 1 -maxdepth 1 -type d -name spec)/..; bin/rspec {spec})"

" let test#typescript#jest#executable = "SKIP_PREFLIGHT_CHECK=true $(yarn bin)/rescripts test"
"
" Map tricky escape sequence to control o
if has('nvim')
  tmap <C-o> <C-\><C-n>
endif

"=========================
" Gist
"=========================
let g:gist_post_private = 1
let g:gist_show_privates = 1
let g:gist_open_browser_after_post = 1

"=========================
" Modern Rails Projections
"=========================

let g:rails_projections = {
      \  "app/controllers/*_controller.rb": {
      \      "test": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/requests/{}_controller_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \      "alternate": [
      \        "spec/requests/{}_spec.rb",
      \        "spec/controllers/{}_controller_spec.rb",
      \        "test/controllers/{}_controller_test.rb"
      \      ],
      \   },
      \   "spec/requests/*_spec.rb": {
      \      "command": "request",
      \      "alternate": "app/controllers/{}_controller.rb",
      \      "template": "require 'rails_helper'\n\n" .
      \        "RSpec.describe '{}' do\nend",
      \   },
      \ }

" let g:gem_projections = {
" k}
"
"=========================
"  Ale configurations
"=========================
" let g:ale_sign_column_always = 1
" let g:ale_sign_error = '!'
" let g:ale_sign_warning = '•'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 1
" let g:ale_ruby_rubocop_executable = 'bundle'
" let g:ale_linters = {
" \   'ruby': ['ruby', 'rubocop', 'brakeman', 'rails_best_practices'],
" \   'typescript': ['tsserver', 'tslint'],
" \   'rust': ['cargo', 'rls'],
" \}
" " let g:ale_linters_ignore = {'typescript': ['tslint']}
" let g:ale_typescript_tsserver_use_global = 1
" let g:ale_typescript_tslint_use_global = 1
" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'rust': ['rustfmt']
" \}
" let g:ale_fix_on_save = 1
" " adjust colors
" " highlight link ALEError Error
" highlight link ALEStyleError Error
" highlight ALEErrorSign guifg=#1E0010
" highlight link ALEWarning WarningMsg
" highlight link ALEStyleWarning WarningMsg
" highlight ALEWarningSign guifg=#FFFFFF

" nmap <leader>af <Plug>(ale_fix)
" nmap <leader>al <Plug>(ale_lint)

"=========================
"  scratch configurations
"=========================

" let g:scratch_persistence_file = '~/.config/nvim/scratch/.rb'


"=========================
"  NVIM terminal config https://github.com/onivim/oni/issues/962
"=========================

autocmd TermOpen * setlocal nonumber norelativenumber

"=========================
"  Emmet configs
"=========================
let g:user_emmet_leader_key=','
let g:user_emmet_settings = {
\  'javascript.jsx' : {
\      'extends': 'jsx',
\  },
\  'javascript' : {
\      'extends': 'jsx',
\  },
\  'typescript' : {
\      'extends': 'jsx',
\  },
\}

"=========================
" Rubocop config
"=========================
let g:vimrubocop_keymap = 0
nmap <Leader>r :RuboCop -a<CR>

"=========================
" ruby editing helpers
"=========================

map <Leader>d orequire 'pry'; binding.pry<esc>:w<cr>

"=========================
" FZF support
"=========================
" https://github.com/junegunn/fzf.vim/issues/59
function! s:update_fzf_colors()
  let rules =
  \ { 'fg':      [['Normal',       'fg']],
    \ 'bg':      [['Normal',       'bg']],
    \ 'hl':      [['Comment',      'fg']],
    \ 'fg+':     [['CursorColumn', 'fg'], ['Normal', 'fg']],
    \ 'bg+':     [['CursorColumn', 'bg']],
    \ 'hl+':     [['Statement',    'fg']],
    \ 'info':    [['PreProc',      'fg']],
    \ 'prompt':  [['Conditional',  'fg']],
    \ 'pointer': [['Exception',    'fg']],
    \ 'marker':  [['Keyword',      'fg']],
    \ 'spinner': [['Label',        'fg']],
    \ 'header':  [['Comment',      'fg']] }
  let cols = []
  for [name, pairs] in items(rules)
    for pair in pairs
      let code = synIDattr(synIDtrans(hlID(pair[0])), pair[1])
      if !empty(name) && code > 0
        call add(cols, name.':'.code)
        break
      endif
    endfor
  endfor
  let s:orig_fzf_default_opts = get(s:, 'orig_fzf_default_opts', $FZF_DEFAULT_OPTS)
  let $FZF_DEFAULT_OPTS = s:orig_fzf_default_opts .
        \ empty(cols) ? '' : (' --color='.join(cols, ','))
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
augroup END

let g:fzf_layout = { 'window': '15new' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:rg_command = '
  \ rg --line-number --smart-case --hidden
  \ -g "*.{sql,R,rs,java,jbuilder,js,jsx,json,php,ctp,css,scss,md,styl,jade,html,config,py,cpp,c,go,hs,rb,erb,conf}"
  \ -g "!{public,.git,node_modules,vendor}/*" '

" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)

let g:fzf_history_dir = '~/.local/share/fzf-history'

" open fzf with rg instead of ctrl p
nnoremap <c-p> :Rg<cr>
" open fzf with rg instead of ctrl p (but with word under cursor
nnoremap <silent> <Leader>p :Rg <C-R><C-W><CR>

" what if vim opened with fzf instead of netrw
