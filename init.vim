"Configuracion nativa
set number
set mouse=a
syntax enable
set showcmd
set encoding=utf-8
set showmatch
set relativenumber

"Plugins
call plug#begin('~/.config/nvim/plugged') "Ruta donde se guardaran los plugins

"Plugin tema
Plug 'sainnhe/gruvbox-material' "Plugin del tema (GRUVBOX)
"Plugins para autocompletado
Plug 'neovim/nvim-lspconfig' "Deteccion de los lenguajes (LSP)
Plug 'nvim-lua/completion-nvim' "Autocompletado de lenguajes
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} "Recuadro para las sugerencias del autocompletado
"Plugins para JavaScript
Plug 'pangloss/vim-javascript' "Resaltado con colores de sintaxis javascript
Plug 'maxmellon/vim-jsx-pretty' "Resaltado con colores de etiquetas html en reactJs
"Plugins para snippets de javascript, reactJs
Plug 'SirVer/ultisnips'
Plug 'mlaursen/vim-react-snippets'
"Plugins para html
Plug 'mattn/emmet-vim' "Snippets para crear etiquetas html
"Plugin comentarios
Plug 'tpope/vim-commentary'
"Plugin de marcado de identacion
Plug 'Yggdroot/indentLine'
"Plugin de barra de estado"
Plug 'vim-airline/vim-airline'
"Plugin de gestor de archivos
Plug 'scrooloose/nerdtree'
"Plugin de fuentes
Plug 'ryanoasis/vim-devicons'

call plug#end()



"----------Configuracion del tema (GRUVBOX)-----------------------
set background=dark "Tipo de fondo (Oscuro)
let g:gruvbox_material_background='medium' "Intensidad o tonalidad del tema
colorscheme gruvbox-material
"----------Fin de la configuracion del tema-----------------------



"-----------Configuracion de los lenguajes-------------------------
lua << EOF
require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.pyright.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.html.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.tailwindcss.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.sqls.setup{on_attach=require'completion'.on_attach}
require'lspconfig'.phpactor.setup{on_attach=require'completion'.on_attach}
EOF
"-----------Fin de la configuracion de lenguajes--------------------



"------------Configuracion de snippets-------------
let g:UtilSnipsExpandTrigger="<tab>"
"------------Fin de configuracion de snippets------



"--------Configuracion de snippets html (Emmet)-------------------
let g:user_emmet_mode='n' "Utilizar el puglin de manera global
let g:user_emmet_leader_key=',' "Al precionar dos veces la tecla se creara la etiqueta html
let g:user_emmet_settings={
\'javascript':{
\ 'extends':'jsx'
\ }
\ } "Utilizar el plugin en archivos jsx
"--------Fin de la configuracion de snippets html (Emmet)----------



"Configuracion de Prettier (Instalar antes :CocInstall coc-prettier)
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <C-D> :Prettier<CR>
"----------Fin de la configuracion de Prettier----------------------



"------Configuracion de comentarios--------------
nnoremap <C-L> :Commentary<CR>
"------Fin de la configuracion de comentarios----



"------Configuracion de diseño de identacion----
let g:indentLine_char = 'c'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" Vim
let g:indentLine_color_term = 239

" GVim
let g:indentLine_color_gui = '#A4E57E'

" none X terminal
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

" Background (Vim, GVim)
let g:indentLine_bgcolor_term = 202
let g:indentLine_bgcolor_gui = '#FF5F00'
"------Fin del diseño de identacion------------


"------Configuracion de barra de estado--------
let g:airline#extensions#tabline#enabled = 1
"------Fin de configuracion de barra de estado--


"------Configuracion del gestor de archivos-----
let NERDTreeQuitOnOpen=1
nnoremap <C-N> :NERDTreeFind<CR>
nnoremap <C-M> :NERDTreeToggle<CR>
"------Fin de la configuracion del gestor-------


"-------Configuracion atajos de teclado--------
"Guardar
nnoremap <C-A> :w<CR>
"Cerrar
nnoremap <C-Q> :q<CR>
"Cerrar y guardar
nnoremap <C-W> :wq<CR>
"-------Fin de la configuracion----------------



"-------Configuracion del recuadro de sugerencia (COC.NVIM) por defecto-------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
"-------------fin de la configuracion general COC.NVIM -------------------
