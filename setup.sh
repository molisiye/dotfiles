#!/bin/bash

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

if [[ ! -a ~/.vimrc ]];
then
  ln -s $script_dir/vimrc ~/.vimrc
fi
