#/bin/bash

xmonad --recompile
ghc ~/.xmonad/xmobar.hs -i$HOME/.xmonad/lib -dynamic -threaded
xmonad --restart
