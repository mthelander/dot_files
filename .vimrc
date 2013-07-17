call pathogen#infect()

"set gfn=SourceCodeProBlack

set nocompatible
set backspace=2		" (bs) allow backspacing over everything in insert mode
set viminfo='20,\"50,%	" (vi) read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" (hi) keep 50 lines of command line history
set ruler		" (ru) show the cursor position all the time
" set textwidth=72

" set mouse=a

set t_Co=256
"colorscheme xoria256

set expandtab
set shiftwidth=4
set showmatch
set wrap
set ai
set incsearch
" set hlsearch
set pastetoggle=<F11>
set showcmd
set hidden

set wildmode=longest,list

set statusline=[%n]\ %F\ %(\ %M%R%H)%)\ \@(%l\,%c%V)\ %P
set laststatus=2

set tags=tags;/

set list listchars=tab:>-,trail:#,extends:>,precedes:<

if has("autocmd")
    autocmd BufEnter * lcd %:p:h
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" work around a bug in some key-maping
" if your 'End' key doesn't work, uncomment these next two lines
" imap [4~ A
" nmap [4~ $

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Switch syntax highlighting on, when the terminal has colors
" Also switch off highlighting the last used search pattern.
if has("syntax") && &t_Co > 2 || has("gui_running")
  if has("gui_running")
    color darkblue
    set guifont=-b&h-lucidatypewriter-medium-r-normal-*-*-120-*-*-m-*-iso8859-1
  endif
  set bg=dark
  augroup filetype
    au! BufRead,BufNewFile *.t  set filetype=perl
    au! BufRead,BufNewFile *.xmobarrc  set filetype=haskell
    au! BufRead,BufNewFile *.html set filetype=mason
    au! BufRead,BufNewFile /tmp/psql\.edit\.* set filetype=sql
    au! BufRead,BufNewFile *.scss set filetype=sass
    au! BufRead,BufNewFile *.thor set filetype=ruby
  augroup END
  syntax on
  hi PreProc ctermfg=Green
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

 autocmd BufReadPost * if line("'\"") | exe "'\"" | endif

 " In text files, always limit the width of text to 78 characters
 autocmd BufRead *.txt set tw=78

 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql nocindent comments=sr:/*,mb:*,el:*/,:// sw=2
  autocmd FileType perl   set autoindent smartindent
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.gz set bin
  autocmd BufReadPost,FileReadPost  *.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost  *.gz set nobin
  autocmd BufReadPost,FileReadPost  *.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.gz !gzip <afile>:r

  autocmd FileAppendPre     *.gz !gunzip <afile>
  autocmd FileAppendPre     *.gz !mv <afile>:r <afile>
  autocmd FileAppendPost    *.gz !mv <afile> <afile>:r
  autocmd FileAppendPost    *.gz !gzip <afile>:r
 augroup END
 augroup bz2
  " Remove all bz2 autocommands
  au!

  " Enable editing of bzipped files
  "   read: set binary mode before reading the file
  "   uncompress text in buffer after reading
  "  write: compress file after writing
  " append: uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre  *.bz2 set bin
  autocmd BufReadPost,FileReadPost  *.bz2 let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost  *.bz2 '[,']!bunzip2
  autocmd BufReadPost,FileReadPost  *.bz2 set nobin
  autocmd BufReadPost,FileReadPost  *.bz2 let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost  *.bz2 execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost  *.bz2 !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost  *.bz2 !bzip2 <afile>:r

  autocmd FileAppendPre     *.bz2 !bunzip2 <afile>
  autocmd FileAppendPre     *.bz2 !mv <afile>:r <afile>
  autocmd FileAppendPost    *.bz2 !mv <afile> <afile>:r
  autocmd FileAppendPost    *.bz2 !bzip2 <afile>:r
 augroup END

 " This is disabled, because it changes the jumplist.  Can't use CTRL-O to go
 " back to positions in previous files more than once.
 if 0
  " When editing a file, always jump to the last cursor position.
  " This must be after the uncompress commands.
   autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif
 endif

endif " has("autocmd")
:abbr #b /********************************************************
:abbr #^b *
:abbr #e ********************************************************/
:abbr #$e \011\011\011\011\011\011\011\011\011\011\011\011\011\011*

if has('eval')
  au BufNewFile,BufRead *.html set filetype=mason

  let CVSCommandDiffOpt='ubBpN'
endif

map ,b :BufExplorer<cr>
map ,n :NERDTree<cr>
map ,t :!rspec %<cr>

set number
set hls
set tabstop=2
set autoindent
set smartindent
command W w
command Wa wa
command Wq wq
nore ; :
map :%s/ \+$//g<CR>
map ,r :!ruy %<CR>
