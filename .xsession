# .xsession
xloadimage -onroot -fullscreen ~/Pictures/xubuntu-karmic.png &
xrdb -merge .Xresources &
setxkbmap -option ctrl:nocaps &
$HOME/bin/xmonad
