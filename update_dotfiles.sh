#!/bin/sh

set -o errexit
set -o xtrace

homeDirectory=/Users/$USER

cp $homeDirectory/.bash_profile \
  $homeDirectory/.bashrc \
  $homeDirectory/.zshrc \
  $homeDirectory/.vimrc \
  $homeDirectory/.gitignore_global \
  $homeDirectory/.gitconfig \
  $homeDirectory/.zshrc.pre-oh-my-zsh \
  $homeDirectory/.iterm2_shell_integration.bash \
  $homeDirectory/.iterm2_shell_integration.zsh \
  $homeDirectory/.npmrc \
  $homeDirectory/.p10k.zsh \
  .

mkdir -p .aws
cp $homeDirectory/.aws/config .aws/

mkdir -p .k9s
cp $homeDirectory/.k9s/config.yml .k9s/

mkdir -p .ssh
cp $homeDirectory/.ssh/bastion.sh \
  $homeDirectory/.ssh/config \
  .ssh/

git add . && git commit -m "Update dotfile with automated script" && git push
