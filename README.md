# vimfiles
My vim configuration.

## Quickstart

``` bash
git clone https://github.com/jweg/vimfiles.git ~/.vim
cd ~/.vim
./init1.sh
vim
```

In Vim:
```
:PluginInstall
ZQ
```

Now we must build the native code parts of some plugins.
Obviously, this is highly platform-specific.
The following instructions assume an Ubuntu system (tested on 14.04 LTS):

``` bash
sudo apt-get install build-essential cmake python-dev
./init2.sh
```
    
