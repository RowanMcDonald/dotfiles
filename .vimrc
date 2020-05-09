"============================================================================
" NEOVIM config of Rowan McDonald // heavily cargo culted
"============================================================================

"=========================
" PLUGINS (using vim-plug)
"=========================

" this is commented out for startup speed but it will auto install vim-plug
" if empty(glob('~/.config/nvim/autoload/plug.vim'))
"   silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
"     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
" endif

call plug#begin('~/.config/nvim/plugged')
"============================
" Plugin graveyard
"============================
"
" Plug 'easymotion/vim-easymotion'         " too much load time :/
" Plug 'wsdjeg/vim-fetch'                  " not using
" Plug 'christoomey/vim-tmux-navigator'    " beautiful plugin, not using tmux rn
" Plug 'kien/ctrlp.vim'                    "  out-growing ctrl-p, 😭
" Plug 'rhysd/git-messenger.vim'           " nice but not needed rn
" Plug 'mattn/gist-vim'                    " rarely use
"   Plug 'mattn/webapi-vim'
" Plug 'SirVer/ultisnips'                  " someday I'll get a working snippets config
" Plug 'danchoi/ri.vim', { 'for': 'ruby' } " coc provides this behavior
" Plug 'ecomba/vim-ruby-refactoring'       " usually can't remember the shortcuts
" Plug 'ngmy/vim-rubocop'                  " not needed
" Plug 'dstein64/vim-startuptime'          " diagnostic
" Plug 'nelstrom/vim-textobj-rubyblock'

" Plug 'rhysd/unite-ruby-require.vim'
" Plug 'camspiers/lens.vim' " auto resizing
  " Plug 'camspiers/animate.vim'

" Cool project, the git integration is great, but sort of redundant over
" existing stuff
" Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'chemzqm/denite-git'

Plug 'tpope/vim-sensible' " normal defaults

" Find and replace using quickfix
Plug 'wincent/ferret' " probably don't need this, could simplify with grep
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'tpope/vim-unimpaired' " faster quickfix nav


" Code manipulation
Plug 'tpope/vim-commentary' " gcc
Plug 'tpope/vim-surround'
Plug 'AndrewRadev/splitjoin.vim' " use gS
Plug 'andymass/vim-matchup'
Plug 'arthurxavierx/vim-caser'
Plug 'junegunn/vim-easy-align'

" Navigation
Plug 'dbakker/vim-projectroot'
Plug 'unblevable/quick-scope' " movement hints with f
Plug 'tpope/vim-vinegar' " netrw+
Plug 'mhinz/vim-startify'

" Search
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'

" integrations
Plug 'tpope/vim-fugitive'  " git commit
  Plug 'tpope/vim-rhubarb' " Enables :Gbrowse

" look and feel
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'sleep/limelight.vim', { 'on': 'Goyo' }
Plug 'itchyny/lightline.vim' " status line
  Plug 'joshdick/onedark.vim'

" coc plugins
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-rls', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-html', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yaml', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-marketplace', {'do': 'yarn install --frozen-lockfile'}
Plug 'fannheyward/coc-sql', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-jest', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-yank', {'do': 'yarn install --frozen-lockfile'}

Plug 'honza/vim-snippets'


" Ruby Support
Plug 'tpope/vim-endwise' " adds end while you're typing
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
let g:ruby_path = '/Users/rowanmcdonald/.rbenv/versions/2.6.1/bin/ruby'
let g:ruby_host_prog = '/Users/rowanmcdonald/.rbenv/versions/2.6.1/bin/ruby'

Plug 'tpope/vim-bundler' " adds gf to Gemfile/ Gemfile.lock
" Gemfile.lock changes working dir, Gemfile does not

Plug 'tpope/vim-rake' " adds vim-rails like nav for gems
  Plug 'tpope/vim-projectionist' " cannot use with @ in path, fork?

" other languages
Plug 'rust-lang/rust.vim'
let g:rust_fold = 1
let g:rustfmt_autosave = 1

" Frontend languages
Plug 'mattn/emmet-vim', { 'for': ['html', 'eruby', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'markdown'] }

Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'json', 'typescript'] }

Plug 'othree/yajs.vim'

" jsx support
Plug 'maxmellon/vim-jsx-pretty'
Plug 'othree/javascript-libraries-syntax.vim'

" Typescript support
Plug 'HerringtonDarkholme/yats.vim'

" plist support
Plug 'darfink/vim-plist'

" testing
Plug 'janko-m/vim-test' " language agnostic test running
Plug 'kassio/neoterm'

" Text obj
Plug 'glts/vim-textobj-comment'
 Plug 'kana/vim-textobj-user'

Plug 'junegunn/vim-xmark', { 'for': 'markdown' }
call plug#end()

""======================
" General vim settings
""======================

set nocompatible " required by at least vim-textobj-rubyblock
runtime macros/matchit.vim "use `%` to navigate between do ... end

set grepprg=rg\ --vimgrep
set clipboard=unnamed
set mouse=
set lazyredraw                        " Reduce the redraw frequency
set formatoptions+=o    " Continue comment marker in new lines.
set modeline            " Enable modeline.
set linespace=0         " Set line-spacing to minimum.
set showcmd                 " Show me what I'm typing
set showmode                    " Show current mode.
set noswapfile                  " Don't use swapfile
set autowrite                   " Automatically save before :next, :make etc.
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats
set showmatch                   " Do not show matching brackets by flickering
set matchtime=1									" Match tenths of a second
set ignorecase                  " Search case insensitive...
set smartcase                   " ... but not when search pattern contains upper case characters

set tabstop=2
set shiftwidth=2
set expandtab
" set relativenumber
set nonumber
set numberwidth=3
set nohlsearch
set notermguicolors
set splitbelow splitright
set undofile
set undodir=~/.config/nvim/undodir
set directory=~/.config/nvim/tmp,.

""======================
" Wildmenu settings
""======================
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
" output current highlight group
nnoremap <f10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<cr>

" Set split to grey line
set fillchars+=vert:\|
hi VertSplit cterm=NONE ctermfg=NONE
hi EndOfBuffer ctermfg=black ctermbg=black
hi HighlightedyankRegion ctermfg=darkgrey ctermbg=0

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
set confirm " this should let me generate

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
      \        "spec/requests/{}_controller_spec.rb",
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
      \   "app/models/*.rb": {
      \     "affinity": "model",
      \     "alternate": [
      \       "spec/models/{}_spec.rb",
      \     ],
      \     "template": ["class {camelcase|capitalize|colons}", "end"],
      \     "type": "model",
      \   },
      \   "spec/models/*_spec.rb": {
      \     "affinity": "model",
      \     "template": [
      \       "require 'rails_helper'",
      \       "",
      \       "RSpec.describe {camelcase|capitalize|colons} do",
      \       "  subject {open} described_class.new {close}",
      \       "",
      \       "  describe 'validations' do",
      \       "    it 'adds an error...' do",
      \       "    end",
      \       "  end",
      \       "",
      \       "  describe '#save!' do",
      \       "    it 'saves x...' do",
      \       "    end",
      \       "  end",
      \       "end"
      \     ],
      \     "type": "unit test"
      \   },
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
let mapleader = "\<SPACE>"

" splitjoin =
nmap <silent> <Leader>jj :SplitjoinJoin<CR>
nmap <silent> <Leader>js :SplitjoinSplit<CR>

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
nnoremap <Leader>fg :call Fzf_dev("git ls-files \| uniq")<CR>
nnoremap <Leader>fl :Lines<CR>
nnoremap <silent> <c-p> :call Fzf_dev($FZF_DEFAULT_COMMAND)<cr>

nnoremap <Leader>s :Startify<cr>

" coq
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>
nnoremap <silent> <space>y  :<C-u>CocList yank<cr>

nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"tags!
nmap <silent> gt <C-]><CR>
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

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

function! s:edit_file(lines)
  if len(a:lines) < 2 | return | endif

  let l:cmd = get({'ctrl-x': 'split',
                 \ 'ctrl-q': 'quickfix',
                 \ 'ctrl-v': 'vertical split',
                 \ 'ctrl-t': 'tabe'}, a:lines[0], 'e')
  if l:cmd == 'quickfix'
    let l:list = []
    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      call add(l:list, l:file_path)
    endfor

    call s:build_quickfix_list(l:list)
  else
    for l:item in a:lines[1:]
      let l:pos = stridx(l:item, ' ')
      let l:file_path = l:item[pos+1:-1]
      execute 'silent '. l:cmd . ' ' . l:file_path
    endfor
  endif
endfunction


function! Fzf_dev(command)
  if (winwidth(0) >= 120)
    let l:fzf_files_options = '--preview "bat --style=numbers,changes --color always {2..} | head -'.&lines.'" --expect=ctrl-v,ctrl-x,ctrl-q'
  else
    let l:fzf_files_options = '--expect=ctrl-v,ctrl-x,ctrl-q'
  endif

  call fzf#run({
        \ 'source': a:command.' | devicon-lookup --color',
        \ 'sink*':   function('s:edit_file'),
        \ 'options': '-m --reverse ' . l:fzf_files_options,
        \ 'down':    '40%',
        \ 'window': 'call CreateCenteredFloatingWindow()'})
endfunction

function! Fzf_git_diff_files_with_dev_icons()
  let l:fzf_files_options = '--ansi --preview "sh -c \"(git diff --color=always -- {3..} | sed 1,4d; bat --color always --style numbers {3..}) | head -'.&lines.'\""'

  function! s:edit_devicon_prepended_file_diff(item)
    echom a:item
    let l:file_path = a:item[7:-1]
    echom l:file_path
    let l:first_diff_line_number = system("git diff -U0 ".l:file_path." | rg '^@@.*\+' -o | rg '[0-9]+' -o | head -1")
    execute 'silent e' l:file_path
    execute l:first_diff_line_number
  endfunction

  call fzf#run({
        \ 'source': 'git -c color.status=always status --short --untracked-files=all | devicon-lookup --color',
        \ 'sink':   function('s:edit_devicon_prepended_file_diff'),
        \ 'options': '-m ' . l:fzf_files_options,
        \ 'down':    '40%' })
endfunction

augroup _fzf
  autocmd!
  autocmd ColorScheme * call <sid>update_fzf_colors()
  autocmd FileType fzf tnoremap <buffer> <esc> <c-c>
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

" I don't /think/ I'm using this?
" let g:rg_command = '
"   \ rg --line-number --smart-case --hidden
"   \ -g "*.{sql,R,rs,java,jbuilder,js,jsx,json,php,ctp,css,scss,md,styl,jade,html,config,py,cpp,c,go,hs,rb,erb,conf}"
"   \ -g "!{public,.git,node_modules,vendor}/*" '

let g:fzf_history_dir = '~/.local/share/fzf-history'


"===============================
" Startify options
"===============================
let g:startify_custom_header_quotes = [
    \ ["Moo"],
    \ ]

function! s:list_commits()
  let git = 'git'
  let commits = systemlist(git .' log --oneline | head -n10')
  let git = 'G'. git[1:]
  return map(commits, '{"line": matchstr(v:val, "\\s\\zs.*"), "cmd": "'. git .' show ". matchstr(v:val, "^\\x\\+") }')
endfunction

let g:startify_lists = [
      \ { 'type': 'dir',                       'header': ['   MRU '. getcwd()] },
      \ { 'type': 'sessions',                  'header': ['   Sessions']       },
      \ { 'type': 'bookmarks',                 'header': ['   Bookmarks']      },
      \ { 'type': 'commands',                  'header': ['   Commands']       },
      \ { 'type': function('s:list_commits'),  'header': ['   Commits']       },
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
      \ {'recore': '~/w/retail/retail_core/'},
      \ {'2020': '~/Dropbox\ \(Betterment\)/Betterment\ Development/database_changes/2020/'},
      \ {'rc': '~/.vimrc'},
      \ ]

autocmd User StartifyBufferOpened ProjectRootCD

"===========================
" Settings for Coc
"===========================
autocmd FileType Ruby let b:coc_root_patterns = ['Gemfile']

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

" Navigate forward and backward in snippets
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'

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

let g:rootmarkers += ['Gemfile', 'package.json', '.gitignore']

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


autocmd BufRead,BufNewFile *.md setlocal spell spelllang=en_us
autocmd FileType gitcommit setlocal spell spelllang=en_us
set complete+=kspell

hi clear SpellBad
hi SpellBad cterm=underline
hi SpellBad ctermfg=red

"================================
" Split join (gS, gJ)
"================================
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_trailing_comma = 1

"================================
" Quick scope - press f see highlights
"================================

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

"===============================
" matchup
"===============================
let g:matchup_matchparen_enabled=0 " do not highlight matches

" :Bashrockets   {:foo => 'bar', :boston => 'rocks'}  ==>   {foo: 'bar', boston: 'rocks'}
" :Hashrockets   {foo: 'bar', boston: 'rocks'}        ==>   {:foo => 'bar', :boston => 'rocks'}
"
" You can select a range before entering these commands. They will apply the
" conversion to all the text in the range.
"
" You can also type the first few characters of either command and try to let
" Vim tab-autocomplete it.
"
" Daniel Choi http://github.com/danchoi
"
function! s:hashrockets() range
  let lnum = a:firstline
  while lnum <= a:lastline
    let newline = substitute(getline(lnum), '\(\w\+\):', ':\1 =>', 'g')
    call setline(lnum, newline)
    let lnum += 1
  endwhile
endfunction

function! s:bashrockets() range
  let lnum = a:firstline
  while lnum <= a:lastline
    let newline = substitute(getline(lnum), ':\(\w\+\)\s*=>', '\1:', 'g')
    call setline(lnum, newline)
    let lnum += 1
  endwhile
endfunction
command! -range Bashrockets :<line1>,<line2>call s:bashrockets() | update
command! -range Hashrockets :<line1>,<line2>call s:hashrockets() | update
