function s:cd(path)
    execute 'cd ' a:path
    echo a:path
endfunction

function! fzf#submodules#components()
  return fzf#run(fzf#wrap({
  \ 'source':  '(while git rev-parse --is-inside-work-tree >/dev/null 2>&1 ;'
  \             . 'do cd $(git rev-parse --show-toplevel);'
  \             . 'git submodule foreach -q --recursive pwd;  cd ..; '
  \             . 'done) | sort -u',
  \ 'sink': function('s:cd'),
  \ 'options': ['-m', '--header-lines', !empty(expand('%')), '--prompt', 'Component> '],
  \}))
endfunction
