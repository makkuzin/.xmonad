xrdb -merge ~/.Xresources
xset r rate 300 30
xbacklight -set 40
xsetroot -cursor_name left_ptr &
xfce4-screensaver &
xfce4-power-manager &
urxvtd --quiet --opendisplay --fork
feh --bg-center ~/.background

export DESKTOP_SESSION=xmonad

export WT=/tmp/worktimer-pipe
[[ -S $WT ]] || mkfifo $WT
echo "off" > $WT &

export SCS=/tmp/soundcardstatus-pipe
[[ -S $SCS ]] || mkfifo $SCS
soundcardstatus > $SCS &

export VPN=/tmp/vpn-pipe
[[ -S $VPN ]] || mkfifo $VPN
echo "" > $VPN &

exec ck-launch-session dbus-launch --sh-syntax --exit-with-session xmonad
