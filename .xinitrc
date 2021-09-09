# !/bin/sh (from xorg-xinit)
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if[-f $sysresources ]; then
    xrdb -merge $sysresources
fi

if[-f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if[-f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if[-f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f"] && . "$f"
    done
    unset f
fi

# Set Chinese locale
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US

# Set fcitx5
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"
fcitx5 &

# IDEA 灰屏解决方案
export _JAVA_AWT_WM_NONREPARENTING=1

# Compositor
picom  -f &

# Wallpaper
nitrogen --restore

# Default backlight software
redshift -O 4500k -r -P


# Loop
while true; do
    dwm >/dev/null 2>&1
done

# Status bar1
while true; do

BA="$( acpi -b | awk '{print $4}' | tr -d ',' )"
VO=$(amixer get Master | tail -n1 | sed -r 's/.*\[(.*)%\].*/\1/')
LOCALTIME=$(date +'D:%Y-%m-%d T:%H:%M:%S')
IP=$(for i in `ip r`; do echo $i; done | grep -A 1 src | tail -n1)
MEMFREE=$(free -h|awk '{print $7}'|awk 'NR==2')

if acpi -a | grep off-line > /dev/null
then

xsetroot -name "IP:$IP RAM:$MEMFREE VOL:$VO BAT:$BA $LOCALTIME"

else

xsetroot -name "IP:$IP RAM:$MEMFREE VOL:$VO PLUG$BA $LOCALTIME"

fi

sleep 1

done &

# Status bar2
dwmstatus 2>&1 >/dev/null &

#Execute DWM
exec dwm
