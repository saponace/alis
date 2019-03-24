#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yay -S --noconfirm --needed"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis.config"
LOG_FILE="./alis.log"
ADDITIONAL_CONFIG_FILES_DIR="files_to_deploy/config-files/other"


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &



if [ ! -f "${CONFIG_FILE_PATH}" ]
then
  echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
  exit 1
fi
source ${CONFIG_FILE_PATH}

# Check if the user that calls this script is the same user as defined in the config file
if [[ ${username} != ${USER} ]];
then
  echo "Error: you are not ${username} as defined in the config file. Please execute this script as ${username}."
  exit 1
fi


# Execute a component file
# $1: The name of the component (without the ending ".sh")
function install_component (){
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Starting installation of component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  # Case components/core/core.sh
  if [ -f "${COMPONENTS_PATH}/$1/$1.sh" ]; then
      source "${COMPONENTS_PATH}/$1/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  # Case components/core.sh
  elif [ -f "${COMPONENTS_PATH}/$1.sh" ]; then
    source "${COMPONENTS_PATH}/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  else
    echo "Error: Component $1 not found"
  fi
  echo "" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Finished installing component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "" 2>&1 | tee -a ${LOG_FILE}
}

function enable_networking (){
  echo "Enabling networking ..."
  sudo dhcpcd
  while [ "$var1" != "end" ]
  do
      pingtime=$(ping -w 1 google.com | grep ttl)
      if [ "$pingtime" = "" ]
      then
          sleep 2
      else
          break
      fi
  done
  echo "Done !"
}


source common-functions.sh


enable-networking

install_component aur-helper
install_component networking
install_component vpn-client
install_component core
install_component dev
install_component utils
install_component display
install_component window-manager
install_component hardware-drivers
install_component desktop-apps
install_component virtualisation
install_component battery-management
install_component font-and-gtk-theme
install_component sound
install_component file-manager
install_component machine-specific
install_component shell-and-term-apps
install_component wallpaper
install_component fs-snapshots
${COMPONENTS_PATH}/link-files.sh

sync
sudo reboot
