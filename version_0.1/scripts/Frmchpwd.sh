#!/bin/bash
#function on click New-password
# read -p "Enter current password: " current
# read -p "Enter new password: " newpw 
# read -p "Enter confirm password: " cofpw
function newpaswd(){
NEWED=$(yad --width="487" --height="450" --center \
--text-align="center" \
--title="New Password" \
--text='<span color=\"#8c1aff\" font="Verdana center 35"><b>'"New Password"'</b></span>' \
--window-icon="/usr/share/pixmaps/pionuxicon.png" \
--image-on-top=center \
--form  \
--field="
<big>Please enter Current password and New password to change your password.</big>
":LBL \
--field="<b><big>Current password</big></b>	":H \
--field="<b><big>New password</big></b>	":H \
--field="<b><big>Confrim</big></b>	":H \
--button="Cancel":1 \
--button="OK":0)
if [ $? -eq 0 ];then #click ok
currentpw=$(echo $NEWED | awk -F'|' '{print $2}')
newpw=$(echo $NEWED | awk -F'|' '{print $3}')
cofpw=$(echo $NEWED | awk -F'|' '{print $4}')
echo $current
echo $newpw
echo $cofpw
if [[ -z "$currentpw" ]];then 
yad --center --width=350 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete Current password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
newpaswd # call function nwepasswd
elif [[ -z "$newpw" ]]; then 
yad --center --width=350 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete New Password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
newpaswd # call function nwepasswd
elif [[ -z "$cofpw" ]]; then
yad --center --width=350 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete Confirm Password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
newpaswd # call function nwepasswd
else 
if [[ $currentpw == $newpw ]];then # compare newpw with currentpasswd
yad --center --width=350 --height=100 \
--text="<span foreground='#ffffff'><b><big>Your Current password is the same
New password. Please try another password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
newpaswd # call function nwepasswd
else
if [[ $newpw != $cofpw ]];then # compare password
    yad --center --width=280 --height=100 \
    --text="<span foreground='#ffffff'><b><big>Your password not match.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
    newpaswd # call function nwepasswd
else 
username=$(id -u -n)
#sudo -k
if sudo -lS &> /dev/null << EOF
$currentpw
EOF
then 
[ -z "${PWD1}"] && PWD1=$currentpw
[ -z "${PWD2}"] && PWD2=$newpw
[ -z "${PWD3}"] && PWD3=$cofpw
cat <<EOF | sudo passwd $username
${PWD1}
${PWD2}
${PWD3}
EOF
sudo -k
if sudo -lS &> /dev/null << EOF1
$newpw
EOF1
then
    yad --center --width=240 --height=100 \
    --text="<span foreground='#00ff00'><b><big>Changed Suceessfully.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-execute" \
    --title="Changed" \
    --button=OK:0
else 
    yad --center --width=290 --height=100 \
    --text="<span foreground='green'><b><big> Change password fail.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
	newpaswd	
fi
else 
    yad --center --width=250 --height=100 \
    --text="<span foreground='#ffffff'><b><big>Wrong Password.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
    newpaswd
fi # end of verify password
fi # end of compare password
fi # end of compare newpw with currentpasswd
fi # end of find value
elif [[ $? -eq 1 ]]; then
    exit
fi #end of click ok
} #end of function newpasswd
newpaswd
