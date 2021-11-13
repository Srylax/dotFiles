#/bin/bash

wal -i $(find ~/Pictures/Wallpapers/ -type f | shuf -n 1)
python ~/.local/bin/razer-cli -e multicolor,xpalette &
pywalfox update &
spicetify apply -nq &
