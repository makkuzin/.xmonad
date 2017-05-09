xrdb -merge ~/.Xresources
xset r rate 300 30
xbacklight -set 40
xsetroot -cursor_name left_ptr &
xscreensaver -no-splash &
urxvtd --quiet --opendisplay --fork
feh --bg-center ~/.backgrounds/kite.jpg

export DESKTOP_SESSION=xmonad
export WT=/tmp/.worktimer-pipe
[[ -S $WT ]] || mkfifo $WT
echo "off" > $WT &

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad
