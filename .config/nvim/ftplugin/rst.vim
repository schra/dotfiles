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
