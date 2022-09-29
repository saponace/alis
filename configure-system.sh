#-------------------------------------------------
# Main script. Calls all the subscripts to initialize the system
# $1: target hardware
#-------------------------------------------------


COMPONENTS_PATH="./components"
LOG_FILE="./alis.log"


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &


target_hardwares=$@

USERNAME=$(whoami)
DOTFILES_SOURCE="dotfiles"
USER_HOME="/home/${USERNAME}"
ROOT_HOME="/root"
SYSTEMD_UNITS_DIRECTORY="/etc/systemd/system"



# Execute a component script
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

# Get partial path of a hardware-specific script from its hardware name
# $1: Name of the hardware
function get_target_hardware_partial_path (){
  echo "hardware-specific/$1/$1"
}

# Check if all specified target hardwares have a configuration script and exit the script if at least one does not exist
function check_target_hardwares_exist (){
  for target_hardware in ${target_hardwares}
  do
    if [ ! -f "${COMPONENTS_PATH}/$(get_target_hardware_partial_path ${target_hardware}).sh" ]; then
      echo "Specified hardware \"${target_hardware}\" is not handled. Please use only the hardwares in ${COMPONENTS_PATH}/hardware-specific"
      exit -1
    fi
  done
}

# Execute all hardware specific scripts
function install_hardware_specific_components (){
  for target_hardware in ${target_hardwares}
  do
    install_component $(get_target_hardware_partial_path ${target_hardware})
  done
}



check_target_hardwares_exist

source ./common-functions.sh

install_component package-manager

install_component system
install_component filesystem
install_component networking
install_component vpn-client
install_component dev
install_component cli-utils
install_component display
install_component window-manager
install_component hardware-drivers
install_component desktop-apps
install_component virtualisation
install_component font-and-gtk-theme
install_component audio
install_component file-manager
install_component terminal-and-shell
install_component gdrive-sync
install_component music-production
install_component gaming

install_hardware_specific_components

sync
sudo reboot
