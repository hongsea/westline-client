#!/bin/bash
ipcrm -a
username=$(id -u -n)
if [[ $username == "ATS" ]];then 
    yad --center --width=280 --height=100 \
    --text="<span foreground='#ffffff'><b><big>Your are not user domain.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
	if [[ $? == 0 ]];then 
	 exit;
	fi 
else 
mount=$(df -h | grep ATS | awk -F' ' '{ if (NR==1) print $1}')
if [[ "$mount" ==  "//ATS/$username" ]]; then
function main1(){
status=Connected
username=$(id -u -n)
action=$(yad --plug=1234601 --tabnum=1 \
--image-align=center \
--image="/usr/share/pixmaps/pionuxicon.png" \
--image-on-top \
--form \
--text="
<span foreground='#7300e6'><b><big><big>$username</big></big></b></span>
" \
--field="Open your Data":fbtn "dolphin --select /home/ATS/$username/$username/" \
--field="
STATUS : <span foreground='green'><b><big><big>$status</big></big></b></span>
":LBL &\
yad --key=1234601 --notebook --seperator='\n' --tab="Login" --width="487" --height="450" --center \
--title="Enterprise Client" \
--text-align="center" \
--text='<span color=\"#8c1aff\" font="Verdana center 40"><b>'"PIONUX"'</b></span>' \
--window-icon="/usr/share/pixmaps/pionuxicon.png" \
--button=Cancel:1 \
--button=Update:"bash -c /usr/bin/Update.sh"  \
--button=OK:0 \
)

if [[ $? -eq 1 ]];then
    exit;
elif [[ $? -eq 0 ]];then
   exit;
fi # end of on click ok
}
main1
else 
	status=Disconnect
#function on click New-password
#yad
#Form for connect and change password
function main(){
action=$(yad --plug=1234601 --tabnum=1 \
--form \
--field="
<big>welcome to pionux.
Please enter your password to access your data.</big>":LBL \
--image-align=center \
--image="/usr/share/pixmaps/pionuxicon.png" \
--text="
<span foreground='#ffffff'><b><big><big>$username</big></big></b></span>
" \
--field=" <b><big>
Username :  $username</big></b>
":LBL \
--field="<b><big>Password  :</big></b>":H \
--field="<b><big>Confirm     : </big></b>":H \
--field="
STATUS: <span foreground='green'><b><big><big>$status</big></big></b></span>
":LBL &\
yad --key=1234601 --notebook --seperator='\n' --tab="Login" --width="487" --height="450" --center \
--title="Enterprise Client" \
--window-icon="/usr/share/pixmaps/pionuxicon.png" \
--text-align="center" \
--text='<span color=\"#8c1aff\" font="Verdana center 40"><b>'"PIONUX"'</b></span>' \
--button=Cancel:1 \
--button=Update:"bash -c /usr/bin/Update"  \
--button=Connect:2 \
--button=OK:0 \
)

if [ $? -eq 2 ];then
passwd=$(echo $action | awk -F'|' '{print $3}')
cofirm=$(echo $action | awk -F'|' '{print $4}')
if [[ -z "$passwd" ]]; then 
yad --center --width=290 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete Password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png"   --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
main # call function main
elif [[ -z "$cofirm" ]]; then
yad --center --width=350 --height=100 \
--text="<span foreground='#ffffff'><b><big>Please complete Confirm Password.</big></b></span>" \
--window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-dialog-warning" \
--title="Warning" \
--button=OK:0
main # call function main
else 
if [[ $passwd != $cofirm ]];then
    yad --center --width=280 --height=100 \
    --text="<span foreground='#ffffff'><b><big>Your password not match.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png" --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
    main #call function main
else 
username=$(id -u -n)
userid=$(id -u)
sudo -k
if sudo -lS &> /dev/null << EOF
$passwd
EOF
then 
[ -z "${PWD1}"] && PWD1=$name
[ -z "${PWD2}"] && PWD2=$passwd
[ -z "${PWD3}"] && PWD3=$cofirm
#cat <<EOF | sudo passwd $username
#${PWD3}
#${PWD3}
#EOF
group=$(id -Gn | awk -F' ' '{ print $10 }')
idg=$
mkdir $HOME/$username > /dev/null 2>&1
mkdir $HOME/share$group > /dev/null 2>&1
rm -rf $HOME/Videos
rm -rf $HOME/Pictures
rm -rf $HOME/Musics
echo $passwd | sudo -S mount -t cifs //ATS/$username $HOME/$username/ -o username=$username,password=$passwd,workgroup=ATS,iocharset=utf8,uid=$userid,gid=users,vers=3.1.1,nodfs --verbose
echo $passwd | sudo -S mount -t cifs //ATS/share$group $HOME/share$group/ -o username=$username,password=$passwd,workgroup=ATS,iocharset=utf8,uid=$userid,gid=$group,vers=3.1.1,nodfs --verbose
mount=$(df -h | grep ATS | awk -F' ' '{ if (NR==1) print $1}')
mountshare=$(df -h | grep ATS | awk -F' ' '{ if (NR==2) print $1}')
mount1="//ATS/$username"
mount2="//ATS/share$group"
	if [[ "$mountshare" != "$mount2" ]];then
	    yad --center --width=260 --height=100 \
	    --text="<span foreground='#00ff00'><b><big>Share group fail.</big></b></span>" \
	    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-connect" \
	    --title="warning" /
		--button=OK:0
	fi 
	if [[ "$mount" ==  "$mount1" ]]; then
	    yad --center --width=260 --height=100 \
	    --text="<span foreground='#00ff00'><b><big>Connected Successfully.</big></b></span>" \
	    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-connect" \
	    --title="Connected" \
	    --button=OK:0
    		if [[ $? == 0 ]]; then
		dolphin --select /home/ATS/$username/$username/
		fi
	else 
	    yad --center --width=260 --height=100 \
	    --text="<span foreground='green'><b><big>Connection failed.</big></b></span>" \
	    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-warning" \
	    --title="warning" \
	    --button=OK:0
		status=Disconnect.
		main
	fi # end of find mount
else 
    yad --center --width=220 --height=100 \
    --text="<span foreground='#ffffff'><b><big>Wrong Password.</big></b></span>" \
    --window-icon="/usr/share/pixmaps/pionuxicon.png"  --image="gtk-dialog-warning" \
    --title="Warning" \
    --button=OK:0
    main
fi #end of verify password
fi # end of compare password
fi # end of find value
elif [[ $? -eq 1 ]];then
    exit;
elif [[ $? -eq 2 ]];then
yad --center
fi # end of on click ok
}
main
fi # end of find mount
fi # end of compare userATS
#--image="/usr/share/pixmaps/pionuxlable.png" \
#update
