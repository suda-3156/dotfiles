" Set leader key
let mapleader = ","
let maplocalleader = ","

" For conciseness
let opts = { 'noremap': 1, 'silent': 1 }

" Disable the spacebar key's default behavior in Normal and Visual modes
nnoremap <Space> <Nop>
vnoremap <Space> <Nop>

" Allow moving the cursor through wrapped lines with j, k
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Clear highlights
nnoremap <Esc> :noh<CR>

" Save file
nnoremap <C-s> :w<CR>

" Quit file
nnoremap <C-q> :q<CR>

" Delete single character without copying into register
nnoremap x "_x

" Vertical scroll and center
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Find and center /での検索時に真ん中に来るようにしている
nnoremap n nzzzv
nnoremap N Nzzzv

" Resize with arrows
nnoremap <Up> :resize -2<CR>
nnoremap <Down> :resize +2<CR>
nnoremap <Left> :vertical resize -2<CR>
nnoremap <Right> :vertical resize +2<CR>

" Buffers
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>x :Bdelete!<CR> " close buffer
nnoremap <leader>b :enew<CR> " new buffer

" Window management
nnoremap <leader>v <C-w>v " split window vertically
nnoremap <leader>h <C-w>s " split window horizontally
nnoremap <leader>se <C-w>= " make split windows equal width & height
nnoremap <leader>xs :close<CR> " close current split window

" Navigate between splits
nnoremap <C-k> :wincmd k<CR>
nnoremap <C-j> :wincmd j<CR>
nnoremap <C-h> :wincmd h<CR>
nnoremap <C-l> :wincmd l<CR>

" Toggle line wrapping
nnoremap <leader>lw :set wrap!<CR>

" Stay in indent mode
vnoremap < <gv
vnoremap > >gv

" Move text up and down Option keyで反応しない
nnoremap <A-j> :m .+1<CR>==
vnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-k> :m .-2<CR>==

" Keep last yanked when pasting
vnoremap p "_dP

" Replace word under cursor
nnoremap <leader>j *``cgn

" Explicitly yank to system clipboard (highlighted and entire row)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Toggle diagnostics
let g:diagnostics_active = 1
nnoremap <leader>do :call ToggleDiagnostics()<CR>

function! ToggleDiagnostics()
  if g:diagnostics_active
    silent! lua vim.diagnostic.disable()
  else
    silent! lua vim.diagnostic.enable()
  endif
  let g:diagnostics_active = !g:diagnostics_active
endfunction

" Diagnostic keymaps
nnoremap [d :lua vim.diagnostic.goto_prev()<CR>
nnoremap ]d :lua vim.diagnostic.goto_next()<CR>
nnoremap <leader>d :lua vim.diagnostic.open_float()<CR>
nnoremap <leader>q :lua vim.diagnostic.setloclist()<CR>

" Save and load session
nnoremap <leader>ss :mksession! .session.vim<CR>
nnoremap <leader>sl :source .session.vim<CR>

" Additional remaps
nnoremap Y y$
nnoremap X "_D
nnoremap U <C-r>
nnoremap M %
nnoremap <A-S-k> :copy-1<CR>
nnoremap <A-S-j> :copy.<CR>

" Move to the end and start of line with <Space>
nnoremap <Space>l $
nnoremap <Space>h ^

" Insert new lines above or below with <Space>
nnoremap <Space>o o<Esc>
nnoremap <Space>O O<Esc>
