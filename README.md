README
======

To use this git repository, backup your existing .vimrc file and .vim
directory ( i use .vimrc.bak and .vim.bak ).  Check out this repository anywhere
local to your machine. Then make a link named .vimrc to the vimrc file in the
repository and a link from the .vim directory to the vim folder in the
repository.

*Note* This repository has submodules as a handy way to link to other git
repositories that are combined into vim with pathogen.  So, please use:

    git clone --recursive https://github.com/muff1nman/Vim.git

Additional/Optional Setup
----------

#### Command-T
Command-T needs a bit of manual setup.  For one, you need to have built vim with
ruby support.  Second, you need to build the C extensions.  This is documented
in the submodule, but in short, once you have recursively cloned this repo, go
into the `vim/bundle/command-t/ruby/command-t` directory and run 

```
ruby extconf.rb
make
```

Please check the README in that submodule as those instructions are most likely
more up to date.

#### Eclimd
TODO

#### Swap Parameters
This plugin will need vim compiled with python support

Compiling Vim
----------
TODO - list needed compile parameters

Rspec Testing
----------
To run rspecs within files, I have added the `vim-rspec` plugin.  When within an
rspec file you can use the following commands:  

``` vim
" Rspec.vim mappings
map <Leader>rf :call RunCurrentSpecFile()<CR>
map <Leader>rs :call RunNearestSpec()<CR>
map <Leader>rl :call RunLastSpec()<CR>
map <Leader>ra :call RunAllSpecs()<CR>
```
