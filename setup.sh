#!/bin/sh -e

cd $HOME

dotdir=.dotfiles/dot
dotfiles=$(cd $dotdir && find * -type f)

for i in $dotfiles; do
	d=$(dirname .$i)
	[ "$d" = '.' ] || mkdir -vp $d
	ln -vfs $HOME/$dotdir/$i .$i
done
