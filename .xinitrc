# Set Chinese locale
export LANG=zh_CN.UTF-8
export LANGUAGE=zh_CN:en_US

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
slstatus &

#Execute DWM
exec dwm
