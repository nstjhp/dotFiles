:set number
:syntax on
:set t_Co=256
" Need .vim/colors/vividchalk.vim
:colorscheme vividchalk

:command WQ wq
:command Wq wq
:command W w
:command Q q

" set whichwrap+=>,l
" set whichwrap+=<,h
" set whichwrap+=[,]
set whichwrap+=<,>,[,]

" Tabs and spaces and all that jazz...
" If things go wrong you can do (from http://stackoverflow.com/a/5144480/3275826)
" :set et       " Switch to 'space mode'
" :retab        " This makes everything spaces
" http://stackoverflow.com/a/1878984/3275826
filetype plugin indent on
set tabstop=4 " The width of a TAB is set to 4.
              " Still it is a \t. It is just that
              " Vim will interpret it to be having
              " a width of 4.
set shiftwidth=4 " Indents will have a width of 4
set softtabstop=4 " Sets the number of columns for a TAB
set expandtab " Expand TABs to spaces
