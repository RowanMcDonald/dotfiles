"============================================================================
" NEOVIM config of Rowan McDonald // heavily cargo culted
"============================================================================

"=========================
" PLUGINS (using vim-plug)
"=========================

" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

" Set split to grey line
set fillchars+=vert:\|
hi VertSplit cterm=NONE ctermfg=NONE
hi EndOfBuffer ctermfg=black ctermbg=black

call plug#begin('~/.config/nvim/plugged')
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
Plug 'wsdjeg/vim-fetch' " vim opens files on indicated line + column
Plug 'tpope/vim-endwise'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'dbakker/vim-projectroot'
Plug 'christoomey/vim-tmux-navigator' "
" Plug 'easymotion/vim-easymotion' " too much load time :/
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'
Plug 'tpope/vim-vinegar' " netrw+
Plug 'arthurxavierx/vim-caser' " change casing

Plug 'tpope/vim-surround'
" Plug 'tpope/vim-dispatch'
" Plug 'w0rp/ale'

" integrations
Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb' " Enables :Gbrowse
Plug 'rhysd/git-messenger.vim'

Plug 'kristijanhusak/vim-carbon-now-sh'
Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim'

" look and feel
Plug 'junegunn/goyo.vim'
Plug 'sleep/limelight.vim'
Plug 'joshdick/onedark.vim' " for lightline
" Plug 'rafi/awesome-vim-colorschemes'
" Plug 'ryanoasis/vim-devicons'
Plug 'itchyny/lightline.vim' " status line
Plug 'mhinz/vim-startify'

" snippits
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
Plug 'neoclide/coc.nvim', {'branch': 'release'}



" Ruby Support
" Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rake'
Plug 'tpope/vim-bundler'
" Plug 'danchoi/ri.vim', { 'for': 'ruby' }
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
 Plug 'kana/vim-textobj-user'
Plug 'AndrewRadev/splitjoin.vim' " use gS

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
" Plug 'jamestthompson3/vim-jest'
Plug 'kassio/neoterm'

" Text obj
Plug 'glts/vim-textobj-comment'
 " Plug 'kana/vim-textobj-user' required above

Plug 'junegunn/vim-xmark', { 'do': 'make' }
Plug 'junegunn/vim-easy-align'

" Plug 'dstein64/vim-startuptime'

call plug#end()

""======================
" General vim settings
""======================

filetype plugin indent on
set nocompatible " required by at least vim-textobj-rubyblock
runtime macros/matchit.vim "use `%` to navigate between do ... end

set clipboard=unnamed
set mouse=a
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
let g:python_host_skip_check=1
let g:python3_host_skip_check=1

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
" Also menus
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

let test#ruby#rspec#executable = 'BUNDLE_GEMFILE=Gemfile.local bundle exec rspec --no-profile'
" nice test splits?
" https://gist.github.com/adamzaninovich/5b9c7544cb0f5e746f75
if has('nvim')

  let test#strategy = "neoterm"
  let g:neoterm_default_mod = "vertical"
  let g:neoterm_autoscroll = 1 " Scroll to bottom when using neoterm
  let g:neoterm_autoinsert = 0
  " let g:neoterm_keep_term_open = 0 "when buffer closes, quit term

  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  function! OpenTermV(...)
    let g:neoterm_size = 80
    let l:cmd = a:1 == '' ? 'pwd' : a:1
    execute 'vert T '.l:cmd
  endfunction

  function! OpenTermH(...)
    let g:neoterm_size = 15
    let l:cmd = a:1 == '' ? 'pwd' : a:1
    execute 'belowright T '.l:cmd
  endfunction

  command! -nargs=? VT call OpenTermV(<q-args>)
  command! -nargs=? HT call OpenTermH(<q-args>)
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

nmap <silent> <Leader>tt :HT<CR>
" nmap <silent> <Leader>ttv :VT<CR>

nmap <Leader>r :RuboCop -a<CR>

" insert pry
map <Leader>ip orequire 'pry'; binding.pry<esc>:w<cr>
" insert datetime
map <Leader>it :put =strftime('# %a %d %b %Y')<cr>o

" find things
nnoremap <silent> <Leader>fw :Rg <C-R><C-W><CR>
nnoremap <Leader>fp :Rg <CR>
nnoremap <Leader>fb :GFiles?<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <silent> <leader>fm :call Fzf_MRU_dev()<CR>
" Replacing ctrl-p with cool (if slightly buggy floating window)
nnoremap <silent> <c-p> :call Fzf_dev()<cr>

nnoremap <Leader>s :Startify<cr>

" coq
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
"
" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)


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

" git messenger
nmap <Leader>gm <Plug>(git-messenger)



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

function! s:edit_file(lines)
  if len(a:lines) < 2 | return | endif

  let l:cmd = get({'ctrl-x': 'split',
               \ 'ctrl-v': 'vertical split',
               \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')

  for l:item in a:lines[1:]
    let l:pos = stridx(l:item, ' ')
    let l:file_path = l:item[pos+1:-1]
    execute 'silent '. l:cmd . ' ' . l:file_path
  endfor
endfunction


function! Fzf_dev()
  if (winwidth(0) >= 120)
    let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {1..-1} | head -'.&lines.'" --expect=ctrl-v,ctrl-x'
  else
    let l:fzf_files_options = '--expect=ctrl-v,ctrl-x'
  endif

  call fzf#run({
        \ 'source': split(system($FZF_DEFAULT_COMMAND), '\n'),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})
endfunction

function! Fzf_MRU_dev()
  if (winwidth(0) >= 120)
    let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {1..-1} | head -'.&lines.'" --expect=ctrl-v,ctrl-x'
  else
    let l:fzf_files_options = '--expect=ctrl-v,ctrl-x'
  endif


  call fzf#run({
        \ 'source': copy(fzf_mru#mrufiles#list()),
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --reverse --prompt "MRU>" ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})
endfunction


augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
  autocmd FileType fzf tnoremap <buffer> <esc> <c-c>

  tnoremap <silent><c-f> <C-\><c-n>:q! <enter> :call Fzf_MRU_dev()i<cr>
augroup END

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:rg_command = '
  \ rg --line-number --smart-case --hidden
  \ -g "*.{sql,R,rs,java,jbuilder,js,jsx,json,php,ctp,css,scss,md,styl,jade,html,config,py,cpp,c,go,hs,rb,erb,conf}"
  \ -g "!{public,.git,node_modules,vendor}/*" '

let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_mru_no_sort = 1


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
let g:startify_session_persistence = 1
let g:startify_files_number=20
let g:startify_bookmarks = [
      \ {'clc': '~/w/for_business/clinic/'},
      \ {'bb': '~/w/for_business/b4b/'},
      \ {'bcore': '~/w/for_business/b4b_core/'},
      \ {'b@': '~/w/for_business/@betterment/b4b/'},
      \ {'aa': '~/w/for_business/auditable_actions/'},
      \ {'rt': '~/w/retail/retail/'},
      \ {'rcore': '~/w/retail/retail_core/'},
      \ {'2020': '~/Dropbox\ \(Betterment\)/Betterment\ Development/database_changes/2020/'},
      \ {'rc': '~/.vimrc'},
      \ ]

autocmd User StartifyBufferOpened ProjectRootCD

"==============================
" Highlighted yank
"==============================
let g:highlightedyank_highlight_duration = 100

augroup vimrc
  " au BufWritePost vimrc,.vimrc nested if expand('%') !~ 'fugitive' | source % | endif

  " Fugitive
  au FileType gitcommit setlocal completefunc=emoji#complete
  au FileType gitcommit nnoremap <buffer> <silent> cd :<C-U>Gcommit --amend --date="$(date)"<CR>
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

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

let g:coc_node_path = "/Users/rowanmcdonald/.nodenv/versions/8.15.1/bin/node"

"=================================
" configure project root
"=================================
if !exists('g:rootmarkers')
  let g:rootmarkers = []
endif

let g:rootmarkers += ['Gemfile', 'package.json']

"=================================
" configure git messenger
"=================================

function! s:setup_git_mess()
  set winhl=Normal:Floating
endfunction
autocmd FileType gitmessengerpopup call <SID>setup_git_mess()

"=================================
" Strip whitespace
"=================================
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd FileType markdown let b:noStripWhitespace=1

"================================
" spelling
"================================

set spelllang=en
autocmd FileType markdown setlocal spell
autocmd FileType eruby setlocal spell
" autocmd BufRead,BufNewFile *.rb setlocal spell
let ruby_spellcheck_strings = 1
hi clear SpellBad
hi SpellBad cterm=underline
hi SpellBad ctermfg=red

"================================
" Split join (gS, gJ)
"================================
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_trailing_comma = 1
