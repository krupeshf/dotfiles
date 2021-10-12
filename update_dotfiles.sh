#!/bin/sh

set -o xtrace

homeDirectory=/Users/$USER

cp $homeDirectory/.bash_profile \
  $homeDirectory/.vimrc \
  $homeDirectory/.gitignore_global \
  $homeDirectory/.zshrc.pre-oh-my-zsh \
  .

mkdir -p .aws
cp $homeDirectory/.aws/config .aws/

mkdir -p .k9s
cp $homeDirectory/.k9s/config.yml .k9s/

git add . && git commit -m "Update dotfile with automated script" && git push
