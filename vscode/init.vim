" vim plug begin--------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
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
language en_US.UTF-8
set enc=utf-8
set fencs=utf-8,euckr
set imsearch=0
" set leader key to <space>
let mapleader = " "
set nowrap
" igasdf case when all lowercase
set noincsearch
set ignorecase
set smartcase
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
set undofile
set noswapfile
" use system clipboard to copy and paste
set clipboard+=unnamedplus
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d
nnoremap <Leader>d "*d
nnoremap <Leader>D "*D
vnoremap <Leader>d "*d
nnoremap x "_x
vnoremap x "_x
"Paste in visual mode without copying
xnoremap p pgvy
" keep indent after new line
nnoremap o ox<BS>
nnoremap O Ox<BS>
" find match, start inplace
nnoremap * *N
vnoremap * y/\V<C-R>*<CR>N
noremap ; n

function! GetVisualSelection()
    try
      let p_save = @p
      normal! "py
      return @p
    finally
      let @p = p_save
    endtry
endfunction

func! SubstituteSelected()
    let selection = @p
    call inputsave()
    let rp = input("Replace '".selection."' with :")
    call inputrestore()
    if empty(rp)
        return
    endif
    execute '%s/'.selection.'/'.rp.'/gc'
endfunc

func! SubstituteX()
    call inputsave()
    let rpthis = input("Pattern :")
    let rp = input("Replace '".rpthis."' with :")
    call inputrestore()
    if empty(rp)
        return
    endif
    execute '%s/'.rpthis.'/'.rp.'/gc'
endfunc

nnoremap <Leader>r :call SubstituteX()<CR>
" vnoremap <Leader>r "py:%s/<C-R>p//gc
vnoremap <Leader>r "py:call SubstituteSelected()<CR> 


if exists('g:vscode')
    " VSCode 
    command! RenameSymbol call VSCodeNotify('editor.action.rename')
    " tab commands define
    command! Tabcgroup call VSCodeNotify('workbench.action.closeEditorsInGroup')
    command! Tabcright call VSCodeNotify('workbench.action.closeEditorsToTheRight')
    command! Tabmovel call VSCodeNotify('workbench.action.moveEditorToLeftGroup')
    command! Tabmover call VSCodeNotify('workbench.action.moveEditorToRightGroup')
    " sidebar commands define
    command! ShowActiveFile call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
    command! FindRef call VSCodeNotify('references-view.findReferences')
    command! FindImpl call VSCodeNotify('references-view.findImplementations')
    command! FindInFile call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>'))})
    command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
    command! ReplaceInFile call VSCodeNotify('workbench.action.replaceInFiles', {'query': expand('<cword>')})
    command! ReplaceInFileS call VSCodeNotify('workbench.action.replaceInFiles', {'query': @p})
    command! SaveAllFiles call VSCodeNotify('workbench.action.files.saveAll')
    command! SaveFile call VSCodeNotify('workbench.action.files.save')
    " editor commands define
    command! NextError call VSCodeNotify('editor.action.marker.next')
    command! NextErrorInFiles call VSCodeNotify('editor.action.marker.nextInFiles')
    command! PrevError call VSCodeNotify('editor.action.marker.prev')
    command! PrevErrorInFiles call VSCodeNotify('editor.action.marker.prevInFiles')
    command! NextChange call VSCodeNotify('workbench.action.editor.nextChange')
    command! PrevChange call VSCodeNotify('workbench.action.editor.previousChange')
    function! ShowChangePreview()
        call VSCodeNotify('closeDirtyDiff')
        call VSCodeNotify('editor.action.dirtydiff.next')
    endfunction
    command! NextConflict call VSCodeNotify('merge-conflict.next')
    command! PrevConflict call VSCodeNotify('merge-conflict.previous')
    command! SearchSymbol call VSCodeNotify('workbench.action.gotoSymbol')
    " Git
    command! GitStatus call VSCodeNotify('workbench.scm.focus')
    command! HunkStage call VSCodeNotify('git.stageSelectedRanges')
    command! HunkUnstage call VSCodeNotify('git.unstageSelectedRanges')
    command! HunkRevert call VSCodeNotify('git.revertSelectedRanges')
    command! Diffget call VSCodeNotify('merge-conflict.accept.selection')
    command! GitBlame call VSCodeNotify('gitlens.toggleFileBlame')
    " tab key to cycle tabs, 
    " must start with Uppercase T, this is vscode workaround
    noremap <silent> <Tab> :Tabnext<CR>
    noremap <silent> <S-Tab> :Tabprev<CR>
    " quit other tabs, quit right
    noremap <silent> <Leader>qa :Tabcgroup<CR>
    noremap <silent> <Leader>qo :Tabonly<CR>
    noremap <silent> <Leader>qr :Tabcright<CR>
    " split move tabs
    noremap <silent> <Leader><Leader>l :Tabmover<CR>
    noremap <silent> <Leader><Leader>h :Tabmovel<CR>
    noremap X :Tabclose<CR>
    " reveal file in explorer
    noremap <silent> <Leader>i :ShowActiveFile<CR>
    " find reference
    nnoremap <silent> gr :FindRef<CR>
    nnoremap <silent> gi :FindImpl<CR>
    " Rename (a.k.a F2)
    nnoremap <silent> <F2> :RenameSymbol<CR>
    " find in files, query: word under caret
    nnoremap <silent> <Leader>f :FindInFile<CR>
    nnoremap <silent> <Leader>F :ReplaceInFile<CR>
    xnoremap <silent> <Leader>f "py<Esc>:FindInFileS<CR>
    xnoremap <silent> <Leader>F "py<Esc>:ReplaceInFileS<CR>
    " save all
    noremap <silent> <Leader>sa :SaveAllFiles<CR>
    noremap <silent> <Leader>ss :SaveFile<CR>
    " goto error mark 
    nnoremap <silent> ]e :NextError<CR>zz
    nnoremap <silent> [e :PrevError<CR>zz
    nnoremap <silent> ]E :NextErrorInFiles<CR>
    nnoremap <silent> [E :PrevErrorInFiles<CR>
    nnoremap <silent> ]c :NextChange<CR>zz
    nnoremap <silent> [c :PrevChange<CR>zz
    nnoremap <silent> ]f :NextConflict<CR>zz
    nnoremap <silent> [f :PrevConflict<CR>zz
    " Git commands
    nnoremap <silent> <Leader>hs :HunkStage<CR>
    nnoremap <silent> <Leader>hu :HunkUnstage<CR>
    nnoremap <silent> <Leader>hr :HunkRevert<CR>
    nnoremap <silent> <Leader>hp :call ShowChangePreview()<CR>
    nnoremap <silent> <Leader>dg :Diffget<CR>
    nnoremap <silent> gs :GitStatus<CR>
    nnoremap <silent> ga :GitBlame<CR>
    
    nnoremap <silent> <Leader>/ :SearchSymbol<CR>

    " use gj gk in markdown files
    autocmd FileType markdown nnoremap <silent> j :call VSCodeNotify('cursorDown')<CR>
    autocmd FileType markdown nnoremap <silent> k :call VSCodeNotify('cursorUp')<CR>
else
    " ordinary neovim
    " show line number in nvim 
    set number
    set mouse=a
endif
