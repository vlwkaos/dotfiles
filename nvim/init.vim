" vim plug begin--------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'unblevable/quick-scope'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
call plug#end()
" plugin settings

" sneak, clever mode
let g:sneak#s_next = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" quickscope underline instead of highlight for compatibility
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

" plugin setting end----------------------

" set leader key to <space>
let mapleader = " "
set fileencoding=utf-8
set nowrap
" ignore case when all lowercase
set ignorecase
set smartcase
set incsearch
" use system clipboard to copy and paste
set clipboard+=unnamedplus
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <Leader>d "*d
nnoremap <Leader>D "*D
vnoremap <Leader>d "*d
" find match, start inplace
nnoremap * *N
" search selected
vmap // y/\V<C-R>*<CR>
" replace shortcut
nnoremap <Leader>r :%s///g<left><left><left>
" replace selected
vmap <Leader>r y:%s/<C-R>*//g<left><left>


if exists('g:vscode')
    " VSCode extension
    " tab commands define
    command! Tabcgroup call VSCodeNotify('workbench.action.closeEditorsInGroup')
    command! Tabcright call VSCodeNotify('workbench.action.closeEditorsToTheRight')
    command! Tabmovel call VSCodeNotify('workbench.action.moveEditorToLeftGroup')
    command! Tabmover call VSCodeNotify('workbench.action.moveEditorToRightGroup')
    " sidebar commands define
    command! ShowActiveFile call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
    command! FindRef call VSCodeNotify('references-view.findReferences')
    command! FindInFile call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>')})
    command! SaveAllFiles call VSCodeNotify('workbench.action.files.saveAll')
    " editor commands define
    command! NextError call VSCodeNotify('editor.action.marker.next')
    " tab key to cycle tabs, 
    " must start with Uppercase T, this is vscode workaround
    noremap <Tab> :Tabnext<CR>
    noremap <S-Tab> :Tabprev<CR>
    " quit other tabs, quit right
    noremap <Leader>qa :Tabcgroup<CR>
    noremap <Leader>qo :Tabonly<CR>
    noremap <Leader>qr :Tabcright<CR>
    " split move tabs
    noremap <Leader>l :Tabmover<CR>
    noremap <Leader>h :Tabmovel<CR>
    " reveal file in explorer
    noremap <Leader>i :ShowActiveFile<CR>
    " find reference
    nnoremap gr :FindRef<CR>
    " find in files, query: word under caret
    noremap <Leader>/ :FindInFile<CR>
    " save all
    noremap <Leader>sa :SaveAllFiles<CR>
    " goto error mark 
    nnoremap <Leader>e :NextError<CR>

else
    " ordinary neovim
    " show line number in nvim 
    set number
endif