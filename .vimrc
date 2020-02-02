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
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'dbakker/vim-projectroot'
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
Plug 'mhinz/vim-startify'

" snippits
" Plug 'SirVer/ultisnips'
" Plug 'ervandew/supertab'
" Plug 'honza/vim-snippets'
" Plug 'SirVer/ultisnips'
Plug 'neoclide/coc.nvim', {'branch': 'release'}


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
Plug 'vim-python/python-syntax'

" Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}

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

Plug 'junegunn/vim-xmark', { 'do': 'make' }
Plug 'junegunn/vim-easy-align'
" Plug 'embear/vim-localvimrc' " respect local vimrc


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

" set relativenumber
set nonumber
set numberwidth=3
set nohlsearch
set incsearch
set notermguicolors
set splitbelow splitright
set backspace=indent,eol,start
set undofile
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
let g:python_host_prog = '~/.pyenv/versions/2.7.16/bin/python'
let g:python3_host_prog = '~/.pyenv/versions/3.7.2/bin/python'

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
let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
let g:ctrlp_custom_ignore = {
												\ 'dir':  '\.git$|vcr\|vendor\|\.hg$\|\.svn$\|\.yardoc\|public\/images\|public\/system\|log\|tmp$',
												\ 'file': '\.exe$\|\.so$\|\.dat$'
												\ }
let g:ctrlp_root_markers = ['Gemfile', 'package.json']
let g:ctrlp_working_path_mode = 'r'
let g:ctrlp_use_caching = 0
let g:ctrlp_show_hidden = 1


"========================
" Lightline
"========================
" hides --insert--
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'filetype' ], [ 'fileformat' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'cocstatus': 'coc#status'
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
let g:easy_align_delimiters = {
\ '>': { 'pattern': '>>\|=>\|>' },
\ '\': { 'pattern': '\\' },
\ '/': { 'pattern': '//\+\|/\*\|\*/', 'delimiter_align': 'l', 'ignore_groups': ['!Comment'] },
\ ']': {
\     'pattern':       '\]\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       ')\zs',
\     'left_margin':   0,
\     'right_margin':  1,
\     'stick_to_left': 0
\   },
\ 'f': {
\     'pattern': ' \(\S\+(\)\@=',
\     'left_margin': 0,
\     'right_margin': 0
\   },
\ 'd': {
\     'pattern': ' \ze\S\+\s*[;=]',
\     'left_margin': 0,
\     'right_margin': 0
\   }
\ }

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

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

" Add ability to switch to schema
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
      \  "spec/factories/*s.rb": {
      \      "command": "factory",
      \      "affinity": "collection",
      \      "alternate": "app/models/%i.rb",
      \      "related": "db/schema.rb#%s",
      \      "test": "spec/models/%i_spec.rb",
      \      "template": "FactoryGirl.define do\n  factory :%i do\n  end\nend",
      \      "keywords": "factory sequence"
      \    },
      \ }
if !exists('g:loaded_projectionist')
  runtime! plugin/projectionist.vim
endif

if !exists('g:projectionist_heuristics')
  let g:projectionist_heuristics = {}
endif

call extend(g:projectionist_heuristics, {
			\ '*.tsx': {
			\   '*.tsx': {
			\     'alternate': '{}.test.tsx',
			\     'type': 'source'
			\   },
			\   '*.test.tsx': {
			\     'alternate': '{}.tsx',
			\     'type': 'test'
			\   },
			\ },
			\ '*.go': {
			\   '*.go': {
			\     'alternate': '{}_test.go',
			\     'type': 'source'
			\   },
			\   '*_test.go': {
			\     'alternate': '{}.go',
			\     'type': 'test'
			\   },
			\ }}, 'keep')

" https://github.com/wincent/wincent/blob/60e0aab821932c247cd70681641bf1d87245ae36/roles/dotfiles/files/.vim/after/plugin/projectionist.vim#L38-L68
" Helper function for batch-updating the g:projectionist_heuristics variable.
" function! s:project(...)
"   for [l:pattern, l:projection] in a:000
"     let g:projectionist_heuristics['*'][l:pattern] = l:projection
"   endfor
" endfunction

" " Set up projections for JS variants.
" for s:extension in ['.js', '.jsx', '.ts', '.tsx']
"   call s:project(
"         \ ['*' . s:extension, {
"         \   'alternate': [
"         \         '{dirname}/{basename}.test' . s:extension,
"         \         '{dirname}/{dirname}.test' . s:extension,
"         \         '{dirname}/__tests__/{basename}.test' . s:extension,
"         \   ],
"         \   'type': 'source'
"         \ }],
"         \ ['*.test' . s:extension, {
"         \       'alternate': [
"         \         '{basename}' . s:extension,
"         \         '{basename}/index' . s:extension
"         \        ],
"         \   'type': 'test',
"         \ }],
"         \ ['**/__tests__/*.test' . s:extension, {
"         \       'alternate': [
"         \         '{basename}' . s:extension,
"         \         '{basename}/index' . s:extension
"         \        ],
"         \   'type': 'test'
"         \ }])
" endfor



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

"=========================
" Leader commands
"=========================

" vim-test
nmap <silent> <Leader>tn :TestNearest<CR>
nmap <silent> <Leader>tf :TestFile<CR>
nmap <silent> <Leader>ts :TestSuite<CR>
nmap <silent> <Leader>tl :TestLast<CR>
nmap <silent> <Leader>tv :TestVisit<CR>

nmap <Leader>r :RuboCop -a<CR>

" insert pry
map <Leader>ip orequire 'pry'; binding.pry<esc>:w<cr>
" insert datetime
map <Leader>it :put =strftime('# %a %d %b %Y')<cr>o
"
nnoremap <silent> <Leader>fw :Rg <C-R><C-W><CR>
nnoremap <Leader>fp :Rg <CR>
nnoremap <Leader>fb :GFiles?<CR>
nnoremap <Leader>fl :Lines<CR>

nnoremap <Leader>s :Startify<cr>

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

let g:fzf_layout = { 'window': '45new' }

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


"===============================
" Startify options
"===============================
let g:startify_custom_header_quotes = [
    \ ["Moo"],
    \ ]
let g:startify_lists = [
      \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'files',     'header': ['   MRU']            },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
let g:startify_enable_special = 0

autocmd User StartifyBufferOpened ProjectRootCD

"==============================
" Highlighted yank
"==============================
let g:highlightedyank_highlight_duration = 100

"============================================================================
" AUTOCMD
"============================================================================
" not currently looking in the correct place?
function! s:syntax_include(lang, b, e, inclusive)
  let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
  if empty(syns)
    return
  endif

  if exists('b:current_syntax')
    let csyn = b:current_syntax
    unlet b:current_syntax
  endif

  let z = "'" " Default
  for nr in range(char2nr('a'), char2nr('z'))
    let char = nr2char(nr)
    if a:b !~ char && a:e !~ char
      let z = char
      break
    endif
  endfor

  silent! exec printf("syntax include @%s %s", a:lang, syns[0])
  if a:inclusive
    exec printf('syntax region %sSnip start=%s\(%s\)\@=%s ' .
                \ 'end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  else
    exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s ' .
                \ 'end=%s%s%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  endif

  if exists('csyn')
    let b:current_syntax = csyn
  endif
endfunction

function! s:file_type_handler()
  if &ft =~ 'jinja' && &ft != 'jinja'
    call s:syntax_include('jinja', '{{', '}}', 1)
    call s:syntax_include('jinja', '{%', '%}', 1)
  elseif &ft =~ 'mkd\|markdown'
    for lang in ['ruby', 'yaml', 'vim', 'sh', 'bash=sh', 'python', 'java', 'c',
          \ 'clojure', 'clj=clojure', 'scala', 'sql', 'gnuplot', 'json=javascript']
      call s:syntax_include(split(lang, '=')[-1], '```'.split(lang, '=')[0], '```', 0)
    endfor

    highlight def link Snip Folded
    setlocal textwidth=78
  elseif &ft == 'sh'
    call s:syntax_include('ruby', '#!ruby', '/\%$', 1)
  endif
endfunction

augroup vimrc
  au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " Included syntax
  au FileType,ColorScheme * call <SID>file_type_handler()

  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>

  " http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  au BufNewFile,BufRead,InsertLeave * silent! match ExtraWhitespace /\s\+$/
  au InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
augroup END

"===========================
" Settings for Coc
"===========================
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" do not show signcolumns
set signcolumn=no

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

inoremap <silent><expr> <c-space> coc#refresh()
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

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

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

let g:coc_node_path = "/Users/rowanmcdonald/.nodenv/versions/8.15.1/bin/node"

"=================================
" configure project root
"=================================
if !exists('g:rootmarkers')
  let g:rootmarkers = []
endif

let g:rootmarkers += ['Gemfile', 'package.json']
