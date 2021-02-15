" :set number
:syntax on
:set t_Co=256
" Need .vim/colors/vividchalk.vim
:colorscheme vividchalk
"set background=light
" let g:solarized_termcolors=256
" colorscheme solarized

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

set paste
set ruler

"store lots of :cmdline history
set history=1000

map <Enter> o<ESC> " http://unix.stackexchange.com/a/14751/59876
map <S-Enter> O<ESC> " to press Enter or Shift-Enter in normal mode to insert
" a blank line below or above current line. 

" Add full file path to your existing statusline
set laststatus=2   "Add statusline (line above where the commands are)
"set statusline+=%F\ %l\:%c
"set statusline+=%t       "tail of the filename
"set statusline+=%y      "filetype
"set statusline+=%=      "left/right separator
"set statusline+=%c-%v,     "cursor column (byte count) dash visual column
"set statusline+=%v,     "visual cursor column
"set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
" 256 colour chart http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html
hi User1 ctermfg=red  ctermbg=red
"hi User1 ctermfg=#ffdad8  ctermbg=#880c0e
hi User2 ctermfg=7  ctermbg=1
hi User3 ctermfg=201  ctermbg=87
"hi User3 ctermfg=#292b00  ctermbg=#f4f597
hi User4 ctermfg=233  ctermbg=155
hi User5 ctermfg=232  ctermbg=82
hi User7 ctermfg=white  ctermbg=88 cterm=bold
hi User8 ctermfg=white  ctermbg=69
hi User9 ctermfg=white  ctermbg=90
hi User0 ctermfg=white  ctermbg=233
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot


