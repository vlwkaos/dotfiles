" should be at the top
" set leader key to <space>
let mapleader =" "
"-----------------------vim plug begin--------------------------
call plug#begin(stdpath('data') . '/plugged')
" navigation
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" file explorer and file searching
" need silversearcher-ag for ignoring node_modules and .gitignore files
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" test suite :TestFile
Plug 'vim-test/vim-test'
" js/ts syntax highlighting
Plug 'pangloss/vim-javascript' " js
Plug 'HerringtonDarkholme/yats'
" Plug 'leafgarland/typescript-vim' " ts syntax
Plug 'peitalin/vim-jsx-typescript' " js/jsx
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jparise/vim-graphql'
" ts/js feature
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" UI
Plug 'psliwka/vim-smoothie'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" theme
Plug 'tomasiser/vim-code-dark'
"Plug 'dracula/vim'
call plug#end()
"---

" ## theme settings
if (has("termguicolors"))
 set termguicolors
endif
colorscheme codedark "dracula
" ## airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#branch#enabled=1
let g:airline_theme = 'codedark'

" ## File explorer NERDTree settings
let g:NERDTreeWinPos= "right" "open to right
let g:NERDTreeWinSize=60
let g:NERDTreeShowHidden = 1
" let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ## fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)
" rg with preview
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)
let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden -g "!node_modules/**" -g "!build/**" -g "!.git/**"' 
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}

" Fzf functions
" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } } 

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" ## CoC extensions :CocInstall
set updatetime=300
let g:coc_global_extensions = [
  \ 'coc-tsserver', 
  \ 'coc-tslint-plugin',
  \ 'coc-json', 
  \ 'coc-css', 
  \ 'coc-html',
  \]

function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(1000, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

" ## sneak, clever mode
let g:sneak#s_next = 1

" 이렇게 해야 적용된다
" ## quickscope underline instead of highlight for compatibility
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END

" git gutter sign color
augroup gutter_colors
  autocmd!
  autocmd ColorScheme * highlight GitGutterAdd guifg='#47b30b'
  autocmd ColorScheme * highlight GitGutterChange guifg='#b3870b'
  autocmd ColorScheme * highlight GitGutterDelete guifg='#b30b0b'
  autocmd ColorScheme * highlight GitGutterChangeDelete guifg='0b7db3'
  autocmd ColorScheme * highlight DiffDelete guifg='#b30b0b'
augroup END
" highlight GitGutterAdd 
"---------------------plugin setting end----------------------

"---------------------vim settings----------------------------
syntax enable
" don't use old regexp engine for performance
set re=0
set hidden " buffer to be hidden instead of close. 
set mouse=a
set formatoptions-=cro " vim file, stop newline comment
set encoding=utf-8
set fileencoding=utf-8
set nowrap
set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey20
" ignore case when all lowercase
set ignorecase
set smartcase
set incsearch
" show line num
set number relativenumber
set cmdheight=2
" tab settings
set tabstop=4
set smarttab
set smartindent
set expandtab
set autoindent
set shiftwidth=4
" file settings
set nobackup
set nowritebackup
set cmdheight=2
" read in external change ex) git switch
set autoread 
set noswapfile
set undofile
" split settings
set splitbelow
set splitright
" for webpack watch
set backupcopy=yes
if !isdirectory($HOME . '/tmpundo')
    call mkdir($HOME . '/tmpundo')
endif
set undodir=~/tmpundo//
" use system clipboard to copy and paste
set clipboard+=unnamedplus
set grepprg=rg\ --vimgrep 
" open diff vertically
set diffopt+=vertical

"---------------------vim settings end-------------------------

" general keymappings
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <Leader>d "*d
nnoremap <Leader>D "*D
vnoremap <Leader>d "*d
nnoremap x "_x
vnoremap x "_x
" find match, start inplace
nnoremap * *N
" search selected
vmap // y/\V<C-R>*<CR>
" replace shortcut
nnoremap <Leader>r :%s///g<left><left><left>
" replace selected
vmap <Leader>r y:%s/<C-R>*//g<left><left>
" change buffers
nnoremap <silent> <Tab> :bnext<CR>
nnoremap <silent> <S-Tab> :bprevious<CR>
" quit commands
noremap <silent> <Leader>qo :%bd\|e#<CR>
noremap <silent> <Leader>qa :xa<CR>
noremap <silent> <Leader>sa :wa<CR>
" close buffer and move to previous buffer
noremap <silent> X :bp\|bd #<CR>
" :wa write all
" :xa exit all

" move split pane
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" move pane
noremap <Leader>h <C-w>H
noremap <Leader>j <C-w>J
noremap <Leader>k <C-w>K
noremap <Leader>l <C-w>L

" resize split pane
noremap <A-J> <C-w>-
noremap <A-K> <C-w>+
noremap <A-H> <C-w><
noremap <A-L> <C-w>>

" Mac OS Alt key bindings
if has("gui_macvim")
    " requires option as +ESC
    tnoremap ^[h <C-\><C-n><C-w>h
    tnoremap ^[j <C-\><C-n><C-w>j
    tnoremap ^[k <C-\><C-n><C-w>k
    tnoremap ^[l <C-\><C-n><C-w>l
    nnoremap ^[h <C-w>h
    nnoremap ^[j <C-w>j
    nnoremap ^[k <C-w>k
    nnoremap ^[l <C-w>l
    noremap ^[J <C-w>-
    noremap ^[K <C-w>+
    noremap ^[H <C-w><
    noremap ^[L <C-w>>
endif

" =============Plugin Key Maps ====================
" ## Toggle NERDTree, reveal File
nnoremap <silent> <leader>b :NERDTreeToggle<CR>
nmap <silent> <leader>i :NERDTreeFind<CR> 

" ## vim-sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ## Coc language feature
" hover
nmap <silent> gh :call CocActionAsync('doHover')<CR>
" go to definition...
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gi <Plug>(coc-implementation)
" goto error
nmap <silent> ]e <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-next)
" ]c, [c for next change

" code action quick fix
nmap <silent> <Leader>. <Plug>(coc-codeaction)
" rename
nmap <silent> <F2> <Plug>(coc-rename)
" move file requires watchman
nmap <Leader><F2> :CocCommand workspace.renameCurrentFile<CR>
function! CustomFormat()
    let save_pos = getpos(".")
    %s/\(\.\.\|\/\|src\)\+\/shared\//@shared\//g
    silent call CocAction('runCommand', 'editor.action.organizeImport')
    silent call CocAction('format')
    silent call setpos(".",save_pos)
endfunction
nmap <silent> <Leader>ff :call CustomFormat()<CR>

" ## fzf-vim
nnoremap <silent> <Leader>/ :Rg<CR>
nnoremap <silent> <Leader>p :FZF<CR>

" git diff tool
nnoremap <silent> <Leader>gs :vertical Gstatus \| vertical resize -60<CR>
nnoremap <silent> <Leader>gc :vertical Git mergetool<CR>
nnoremap <silent> <Leader>gd :Gdiff!<CR>
nnoremap <silent> <Leader>dgl :diffget //3<CR>
nnoremap <silent> <Leader>dgh :diffget //2<CR>


set exrc
set secure
