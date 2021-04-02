" vim plug begin--------------------------
call plug#begin(stdpath('data') . '/plugged')
Plug 'unblevable/quick-scope'
Plug 'tpope/vim-repeat'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'bkad/CamelCaseMotion'
call plug#end()
" plugin settings

let g:camelcasemotion_key = '<leader>'

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
" select line without \n
vnoremap al :<C-U>normal 0v$h<CR>
omap al :normal val<CR>
vnoremap il :<C-U>normal ^vg_<CR>
omap il :normal vil<CR>
" find match, start inplace
nnoremap * *N
vnoremap * y/\V<C-R>*<CR>N
noremap ; n
" last non-blank character
noremap $ g_

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
    " execute '/'.selection <CR>
    let rp = input("Replace '".selection."' with :")
    call inputrestore()
    execute '%s/'.selection.'/'.rp.'/gc'
endfunc

func! SubstituteX()
    call inputsave()
    let rpthis = input("Pattern :")
    " execute '/'.rpthis <CR>
    let rp = input("Replace '".rpthis."' with :")
    call inputrestore()
    execute '%s/'.rpthis.'/'.rp.'/gc'
endfunc


if exists('g:vscode')
    " VSCode 
    command! Whichkey call VSCodeNotify('whichkey.show')
    noremap ' :Whichkey<CR>
    " tab commands define
    " sidebar commands define
    command! ShowActiveFile call VSCodeNotify('workbench.files.action.showActiveFileInExplorer')
    command! FindRef call VSCodeNotify('references-view.findReferences')
    command! FindImpl call VSCodeNotify('references-view.findImplementations')
    " replace command
    " save
    command! SaveAllFiles call VSCodeNotify('workbench.action.files.saveAll')
    command! SaveFile call VSCodeNotify('workbench.action.files.save')
    " editor commands define
    function! ShowChangePreview()
        call VSCodeNotify('closeDirtyDiff')
        call VSCodeNotify('editor.action.dirtydiff.next')
    endfunction
    " Git
    command! GitStatus call VSCodeNotify('workbench.scm.focus')
    command! HunkStage call VSCodeNotify('git.stageSelectedRanges')
    command! HunkUnstage call VSCodeNotify('git.unstageSelectedRanges')
    command! HunkRevert call VSCodeNotify('git.revertSelectedRanges')
    command! Diffget call VSCodeNotify('merge-conflict.accept.selection')
    command! GitBlame call VSCodeNotify('gitlens.toggleFileBlame')
    " command palette
    command! ShowAllCommands call VSCodeNotify('workbench.action.showCommands')
    noremap <silent> <Leader><Leader> :ShowAllCommands<CR>
    " tab commands
    command! Tabcgroup call VSCodeNotify('workbench.action.closeEditorsInGroup')
    command! Tabcright call VSCodeNotify('workbench.action.closeEditorsToTheRight')
    command! Tabmovelg call VSCodeNotify('workbench.action.moveEditorToLeftGroup')
    command! Tabmoverg call VSCodeNotify('workbench.action.moveEditorToRightGroup')
    command! Tabmovel call VSCodeNotify('workbench.action.moveEditorLeftInGroup')
    command! Tabmover call VSCodeNotify('workbench.action.moveEditorRightInGroup')
    command! EditorViewSizeToggle call VSCodeNotify('workbench.action.toggleEditorWidths')
    " must start with Uppercase T, this is vscode workaround
    noremap <silent> <Tab> :Tabnext<CR>
    noremap <silent> <S-Tab> :Tabprev<CR>
    " quit other tabs, quit right
    noremap <silent> <Leader>ta :Tabcgroup<CR>
    noremap <silent> <Leader>to :Tabonly<CR>
    noremap <silent> <Leader>tr :Tabcright<CR>
    " split move tabs
    noremap <silent> <Leader>tl :Tabmoverg<CR>
    noremap <silent> <Leader>th :Tabmovelg<CR>
    noremap <silent> <Leader><Tab> :Tabmover<CR>
    noremap <silent> <Leader><S-Tab> :Tabmovel<CR>
    noremap <silent> <Leader>ts :EditorViewSizeToggle<CR>
    " reveal file in explorer
    noremap <silent> <Leader>i :ShowActiveFile<CR>
    " find reference
    nnoremap <silent> gr :FindRef<CR>
    nnoremap <silent> gi :FindImpl<CR>
    " Rename (a.k.a F2)
    command! RenameSymbol call VSCodeNotify('editor.action.rename')
    nnoremap <silent> <F2> :RenameSymbol<CR>
    " find in files, query: word under caret
    command! FindInFile call VSCodeNotify('workbench.action.findInFiles', {'query': expand('<cword>')})
    command! FindInFileS call VSCodeNotify('workbench.action.findInFiles', {'query': @p})
    nnoremap <silent> <Leader>f :FindInFile<CR>
    xnoremap <silent> <Leader>f "py<Esc>:FindInFileS<CR>
    command! ReplaceInFile call VSCodeNotify('workbench.action.replaceInFiles', {'query': expand('<cword>')})
    command! ReplaceInFileS call VSCodeNotify('workbench.action.replaceInFiles', {'query': @p})
    nnoremap <Leader>r :call SubstituteX()<CR>
    vnoremap <Leader>r "py:call SubstituteSelected()<CR> 
    nnoremap <silent> <Leader>R :ReplaceInFile<CR>
    xnoremap <silent> <Leader>R "py<Esc>:ReplaceInFileS<CR>
    " save all
    noremap <silent> <Leader>sa :SaveAllFiles<CR>
    noremap <silent> <Leader>ss :SaveFile<CR>
    " goto error mark 
    command! NextChange call VSCodeNotify('workbench.action.editor.nextChange')
    command! PrevChange call VSCodeNotify('workbench.action.editor.previousChange')
    nnoremap <silent> ]e :NextError<CR>
    nnoremap <silent> [e :PrevError<CR>
    command! NextChange call VSCodeNotify('workbench.action.editor.nextChange')
    command! PrevChange call VSCodeNotify('workbench.action.editor.previousChange')
    nnoremap <silent> ]c :NextChange<CR>
    nnoremap <silent> [c :PrevChange<CR>
    command! NextConflict call VSCodeNotify('merge-conflict.next')
    command! PrevConflict call VSCodeNotify('merge-conflict.previous')
    nnoremap <silent> ]f :NextConflict<CR>
    nnoremap <silent> [f :PrevConflict<CR>
    command! GitPreviousRevision call VSCodeNotify('gitlens.diffWithPrevious')
    command! GitNextRevision call VSCodeNotify('gitlens.diffWithNext')
    nnoremap <silent> [r :GitPreviousRevision<CR>
    nnoremap <silent> ]r :GitNextRevision<CR>
    " Git commands
    nnoremap <silent> <Leader>hs :HunkStage<CR>
    nnoremap <silent> <Leader>hu :HunkUnstage<CR>
    nnoremap <silent> <Leader>hr :HunkRevert<CR>
    nnoremap <silent> <Leader>hp :call ShowChangePreview()<CR>
    nnoremap <silent> <Leader>dg :Diffget<CR>
    nnoremap <silent> gs :GitStatus<CR>
    nnoremap <silent> ga :GitBlame<CR>

    " use gj gk in markdown files
    autocmd FileType markdown nnoremap <silent> j :call VSCodeNotify('cursorDown')<CR>
    autocmd FileType markdown nnoremap <silent> k :call VSCodeNotify('cursorUp')<CR>
else
    " ordinary neovim
    " show line number in nvim 
    set number
    set mouse=a
    
    nnoremap <Leader>r :%s///gc<Left><Left><Left><Left>
    vnoremap <Leader>r "py:%s/<C-R>p//gc<Left><Left><Left>
endif
