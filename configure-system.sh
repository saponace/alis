#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yaourt -S --noconfirm"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis.config"
LOG_FILE="./alis-server.log"
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
# The name of the component (without the ending ".sh")
function install_component (){
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Starting installation of component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  source "${COMPONENTS_PATH}/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Finished installing component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "" 2>&1 | tee -a ${LOG_FILE}
}


# These three components are required in order (and in this order) to make all the following work
source common-functions.sh
install_component enable-networking
install_component aur-helper

install_component network-related
install_component core
install_component dev
install_component utils
install_component x-related
install_component hardware-drivers
install_component misc
install_component misc-gui
install_component virtualbox
install_component battery-management
install_component font-and-gtk-theme
install_component sound-related
install_component file-manager
install_component machine-specific
install_component shell-and-term-related
install_component cron-jobs
install_component lock-screen-script-dependencies
install_component fs-snapshots
${COMPONENTS_PATH}/link-files.sh

sync
sudo reboot
