call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'jiangmiao/auto-pairs'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
call plug#end()


set tabstop=4
set shiftwidth=4
set expandtab


set number
set relativenumber
set list
set listchars=tab:>\ ,trail:·,space:·


set termguicolors

set noshowmode
let g:airline_theme = 'catppuccin_mocha'
" let g:airline_section_separators = ['', '']
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''

" set background=dark
" let g:gruvbox_contrast_dark = 'hard'
autocmd ColorScheme catppuccin_mocha highlight SpecialKey guifg=#3a3a3a
colorscheme catppuccin_mocha


syntax on
filetype plugin indent on
let g:lsp_document_highlight_enabled = 1
let g:lsp_semantic_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
set completeopt=menuone,noinsert,noselect,preview


nmap <silent> gd <plug>(lsp-definition)
nmap <silent> gr <plug>(lsp-references)
nmap <silent> gh  <plug>(lsp-hover)
nmap <silent> g<CR> <plug>(lsp-rename)
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

nnoremap <Space><Space> :Ex<CR>


function! FormatCAndKeepCursor()
    let l:save = winsaveview()
    silent %!clang-format
    call winrestview(l:save)
endfunction

function! FormatZigAndKeepCursor()
    let l:save = winsaveview()
    let l:output = systemlist('zig fmt --stdin', getline(1, '$'))
    if v:shell_error == 0
        silent undojoin | %delete | call setline(1, l:output)
    else
        echohl ErrorMsg
        echo join(l:output, "\n")
        echohl None
    endif
    call winrestview(l:save)
endfunction

function! FormatGoAndKeepCursor()
    let l:save = winsaveview()
    let l:output = systemlist('gofmt', getline(1, '$'))

    if v:shell_error == 0
        silent undojoin | %delete | call setline(1, l:output)
    else
        echohl ErrorMsg
        echo "Go Format Error: " . join(l:output, "\n")
        echohl None
    endif
    call winrestview(l:save)
endfunction


autocmd BufWritePre *.c,*.cpp,*.h,*.hpp call FormatCAndKeepCursor()
autocmd BufWritePre *.zig call FormatZigAndKeepCursor()
autocmd BufWritePre *.go call FormatGoAndKeepCursor()
