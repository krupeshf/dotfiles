#!/bin/sh

cp /home/$USER/.bash_profile .

git add . && git commit -m "Updating dotfile with automated script" && git push
