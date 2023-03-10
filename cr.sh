#!/bin/bash

# Visual Functions #
print_brake() {
  for ((n = 0; n < $1; n++)); do
    echo -n "#"
  done
  echo ""
}

hyperlink() {
  echo -e "\e]8;;${1}\a${1}\e]8;;\a"
}

YELLOW="\033[1;33m"
RESET="\e[0m"
RED='\033[0;31m'
o='\033[0m'
r='\033[1;31m'
b='\033[1;36m'
bx='\033[2;7;36m'
w='\033[1;37m'
y='\033[1;33m'
g='\033[1;32m'

error() {
  echo ""
  echo -e "* ${RED}ERROR${RESET}: $1"
  echo ""
}

# Check Curl #
if ! [ -x "$(command -v curl)" ]; then
  echo "* curl is required in order for this script to work."
  echo "* install using apt (Debian and derivatives) or yum/dnf (CentOS)"
  exit 1
fi

cancel() {
echo
echo -e "* ${RED}Installation Canceled!${RESET}"
done=true
exit 1
}

done=false

echo
print_brake 35
echo -e "${g}CR DPANEL INSTALLER"
echo
echo -e "${y}Beta Version"
print_brake 35
echo

Install() {
bash <(curl -s https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 --output cr)
chmod +x cr
echo -e "${g}Successfully install cr Dpanel"
}

Start() {
./cr tunnel login
}


while [ "$done" == false ]; do
  options=(
    "Install CR Dpanel"
    "Start Run Domain"
    
    "Cancel Installation"
  )
  
  actions=(
    "Install"
    "Start"
    
    "cancel"
  )
  
  echo "Silahkan pilih yang anda inginkan!!"
  echo
  
  for i in "${!options[@]}"; do
    echo "[$i] ${options[$i]}"
  done
  
  echo
  echo -n "* Input 0-$((${#actions[@]} - 1)): "
  read -r action
  
  [ -z "$action" ] && error "Input is required" && continue
  
  valid_input=("$(for ((i = 0; i <= ${#actions[@]} - 1; i += 1)); do echo "${i}"; done)")
  [[ ! " ${valid_input[*]} " =~ ${action} ]] && error "Invalid option"
  [[ " ${valid_input[*]} " =~ ${action} ]] && done=true && eval "${actions[$action]}"
done
