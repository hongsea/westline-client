#!/bin/bash
function main(){
YAD=$(yad --center --width=290 --height=100 --title="Update"  \
--form \
--window-icon="/usr/share/pixmaps/pionuxicon.png" \
--field="Enter password":H \
--button=Cancel:1 \
--button=OK:0)
if [[ $? -eq 0 ]];then # click ok
passwd=$(echo $YAD | awk -F'|' '{print $1}')
if [[ -z "$passwd" ]]; then # find password null or not
yad --center --width=290 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
main
else 
echo $passwd
sudo -k
if sudo -lS &> /dev/null << EOF
$passwd
EOF
then
echo $passwd | sudo -S wget http://koompi/
update=$(cat ~/index.html | grep "#update")
if [[ $update == "#update" ]];then 
	echo $passwd | sudo -S cp /usr/bin/client.sh /usr/bin/client.sh.backup
	echo $passwd | sudo -S cp ~/index.html /usr/bin/client.sh
	echo $passwd | sudo rm -rf ~/index.html
	echo $passwd | sudo chmod +x /usr/bin/client.sh
yad --center --width=290 --height=100 \
--text="<span foreground='#00ff00'><b><big>Updated sucessfully.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-execute" \
--title="Update" \
--button=OK:0
else 
yad --center --width=290 --height=100 \
--text="<span foreground='#ffffff'><b><big>Everything is up to date.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-execute" \
--title="Update" \
--button=OK:0
echo $passwd | sudo rm -rf ~/index.html
fi
else 
yad --center --width=290 --height=100 \
--text="<span foreground='#ffffff'><b><big>Wrong password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
main
echo $passwd | sudo rm -rf ~/index.html
fi 
fi # end of find password null or not
else
	exit;
fi #end if click ok
}
main
