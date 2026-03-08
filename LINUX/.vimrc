set tabstop=4
set shiftwidth=4
set expandtab

set number
set list
set listchars=tab:>\ ,trail:·,space:·

set termguicolors
colorscheme catppuccin_mocha
autocmd ColorScheme * highlight SpecialKey guifg=#3a3a3a

syntax on
filetype plugin indent on
let g:lsp_document_highlight_enabled = 1
let g:lsp_semantic_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
set completeopt=menuone,noinsert,noselect,preview

call plug#begin('~/.vim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()

nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gh  <plug>(lsp-hover)
nmap <silent> g<CR> <plug>(lsp-rename)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

function! FormatAndKeepCursor()
    let l:save = winsaveview()
    silent %!clang-format
    call winrestview(l:save)
endfunction

autocmd BufWritePre *.c,*.cpp,*.h,*.hpp call FormatAndKeepCursor()
