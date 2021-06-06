
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

picom  -CGb &

fcitx &

nitrogen --restore

redshift -O 4500k -r -P

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



exec dwm
