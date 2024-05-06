#!/bin/sh

set -o errexit
set -o xtrace

homeDirectory=/Users/$USER

cp $homeDirectory/.bash_profile \
  $homeDirectory/.bashrc \
  $homeDirectory/.zshrc \
  $homeDirectory/.zprofile \
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

brew list --formula -1 > brew_formulas.txt
brew list --casks -1 > brew_casks.txt

# https://apple.stackexchange.com/a/279078
# for i in $(cat brew_formulas.txt); do; brew install "$i"; done
# for i in $(cat brew_casks.txt); do; brew install "$i"; done

printf "To import exported extensions\n\n\n" > vscode_extensions.txt
code --list-extensions | xargs -L 1 echo code --install-extension >> vscode_extensions.txt

# for vscode, look at cleaner options - https://github.com/codebling/vs-code-default-keybindings

# for iterm profiles -->> Preferences > Profiles > Default > Other Actions > Save Profile as JSON
# https://medium.com/@ratchada.jududom/how-to-ssh-iterm2-with-password-manager-576b0452b493

# for backing up intellij settings - https://gist.github.com/jimzhan/529aa82465549043d883f739e9e93701
# manually export all the settings for intellij > File > Manage IDE Settings > Export

# download the keymap bindings using via - https://usevia.app/#/, save it in downloads folder
cp ~/downloads/keychron_v10_ansi_knob.layout.json keychron_v10_ansi_knob.layout.json

git add . && git commit -m "Update dotfile with automated script" && git push
