#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yaourt -S --noconfirm"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis.config"
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
install_component enable-networking.sh
install_component aur-helper.sh

install_component network-related.sh
install_component core.sh
install_component dev.sh
install_component utils.sh
install_component x-related.sh
install_component hardware-drivers.sh
install_component misc.sh
install_component misc-gui.sh
install_component virtualbox.sh
install_component battery-management.sh
install_component font-and-gtk-theme.sh
install_component sound-related.sh
install_component file-manager.sh
install_component machine-specific.sh
install_component shell-and-term-related.sh
install_component cron-jobs.sh
install_component lock-screen-script-dependencies.sh
install_component fs-snapshots.sh
${COMPONENTS_PATH}/link-files.sh

sync
sudo reboot
