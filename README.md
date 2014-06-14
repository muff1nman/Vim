vim-rdy
=======

This is vim ready to go. It comes with the most useful plugins and has nice
default configurations for many programming languages.  Really, this is an
attempt to make vim more suitable for programming as it tries to include the
most important features that IDEs might have.

Installation
------

For Arch Linux users, you can install vim-rdy system-wide from the AUR.

For everyone else or if you want to install to your home directory, read on!

*WARNING* This is still a work in progress and there are many undocumented
dependencies. Also the vimrc file by default is tailored to Arch Linux users.
This will hopefully change soon!

To use this vim-rdy, backup your existing .vimrc file and .vim
directory.  Clone out this repository anywhere
local to your machine making sure to get all submodules:

    git clone --recursive https://github.com/muff1nman/Vim.git

Then, build the project, by running in the top directory:

	cmake .
	make

Then, copy the vim directory and vimrc file to wherever you want.

Customizing
-----------
If you installed this package to `/usr/share/vim/vimfiles`, you can override
some of the settings by creating your own `.vimrc` file in your home directory.
For example, to choose a different color scheme:

	colorscheme ir_black

