# vimfiles
My vim configuration.

##Quickstart

git clone https://github.com/jweg/vimfiles.git ~/.vim
cd ~/.vim
./init1.sh
vim

In Vim:
:PluginInstall
ZQ

Now we must build the native code parts of some plugins.
Obviously, this is highly platform-specific.
The following instructions assume an Ubuntu system (tested on 14.04 LTS):

Make sure prerequisites are installed
sudo apt-get install build-essential cmake python-dev

then 
./init2.sh
    
##Details

Except for vundle itself which is included as a submodule, the plugins are only
defined in the vimrc. However, some plugins have a native component which must
be built after installing the plugin via :PluginInstall.

youcompleteme:
    Windows:
        Using a prebuilt version from TODO
    Linux:
        cd ~/.vim/unversioned/bundle/YouCompleteMe
        ./install.sh --clang-completer
        
ctrlp-cmatcher:
    Windows:
        I'm ony using this plugin on Linux as I couldn't get it to work on Windows.
    Linux (Ubuntu):
        sudo apt-get install python-dev
        cd ~/.vim/unversioned/bundle/ctrlp-cmatcher
        ./install.sh

vimproc.vim:
    Windows:
        TODO
    Linux:
       cd ~/.vim/unversioned/bundle/vimproc.vim
       make
        
