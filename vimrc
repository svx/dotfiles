syntax on
colorscheme molokai
set t_Co=256
set number
filetype off
"filetype plugin indent on
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" " required! 
" Bundle 'gmarik/vundle'
"
" " My bundles here:
" "
" " original repos on GitHub
Bundle 'Rykka/riv.vim'
Bundle 'scrooloose/nerdtree'
filetype plugin indent on
au FileType python map <buffer> <F6> :!pep8 %<CR>
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
autocmd FileType python set omnifunc=pythoncomplete#Complete
set expandtab
set textwidth=79
set tabstop=8
set softtabstop=4
set shiftwidth=4
set autoindent
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Autocommands {
"      "Python {
       au BufRead,BufNewFile *.py match ErrorMsg '\%>80v.\+'
    "}
"   }

" powerline
set rtp+=/home/svx/.vim/powerline/powerline/bindings/vim


"statusline
set laststatus=2
if has('statusline')
set statusline=%<%f\
set statusline+=%w%h%m%r
set statusline+=%{fugitive#statusline()}
set statusline+=\ [%{&ff}/%Y
set statusline+=\ [%{getcwd()}]
set statusline+=%=%-14.(Line:\ %l\ of\ %L\ [%p%%]\ -\ Col:\ %c%V%)
endif

" Toggle folds with space.
" nnoremap <Space> za
" vnoremap <Space> za

""""""""""""""""""""
" GnuPG Extensions "
"""""""""""""""""""
"
" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    set foldmethod=marker
" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction

" Open Nerdtree with n
map <C-n> :NERDTreeToggle<CR>
