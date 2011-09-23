#!/bin/sh -e

cd $HOME

dotdir=.dotfiles/dot
dotfiles=$(cd $dotdir && find * -type f)

for i in $dotfiles; do
	ln -vfs $HOME/$dotdir/$i .$i
done
