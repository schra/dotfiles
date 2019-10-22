" t as in title
" you e.g. type <leader>t= for getting the line underlined with =
noremap <leader>t YpVr
" I often forget to press shift -> I type a 0 instead of a =
noremap <leader>t0 YpVr=

" sort entries of a toctree
function! MySortToctree()
  let l:save_pos = getcurpos()
  execute "normal! /\.\. toctree:\<cr>:noh\<cr>}V}:sort\<cr>"
  " restore cursor position
  call cursor(l:save_pos[1:])
endfunction
nnoremap <leader>st :call MySortToctree()<cr>

" sort Paragraph
nnoremap <leader>sp vip:sort i<cr>
