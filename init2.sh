#!/usr/bin/env bash

pushd ~/.vim/unversioned/bundle/YouCompleteMe
./install.sh --clang-completer
popd

pushd ~/.vim/unversioned/bundle/vimproc.vim
make
popd
