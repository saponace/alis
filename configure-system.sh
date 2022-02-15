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


target_hardware=${1:-"generic"}
hardware_specific_script_partial_path="hardware-specific/${target_hardware}/${target_hardware}"

USERNAME=$(whoami)
DOTFILES_SOURCE="dotfiles"
USER_HOMEDIR_DOTFILES_DESTINATION="/home/${USERNAME}"
ROOT_HOMEDIR_DOTFILES_DESTINATION="/root"
SYSTEMD_UNITS_DIRECTORY="/etc/systemd/system"


# Check if target hardware is "generic". Retuns true if it is, false otherway
function is_target_hardware_generic (){
  if [ "${target_hardware}" == "generic" ]; then
    return 0
  else
    return 1
  fi
}



# Check if the target hardware has a configuration script and exit the script if it does not exist
function check_target_hardware_exists (){
  if ! is_target_hardware_generic && [ ! -f "${COMPONENTS_PATH}/${hardware_specific_script_partial_path}.sh" ]; then
    echo "Specified hardware \"${target_hardware}\" is not handled. Please use one of the hardwares in ${COMPONENTS_PATH}/hardware-specific"
    exit -1
  fi
}

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


check_target_hardware_exists

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

if ! is_target_hardware_generic; then
  install_component ${hardware_specific_script_partial_path}
fi

sync
sudo reboot
