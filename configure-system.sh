#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yaourt -S --noconfirm"
SOURCE="source"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis.config"


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


# These two components are required in order to make all the following work
${SOURCE} ${COMPONENTS_PATH}/enable-networking.sh
${SOURCE} ${COMPONENTS_PATH}/aur-helper.sh

${SOURCE} ${COMPONENTS_PATH}/network-related.sh
${SOURCE} ${COMPONENTS_PATH}/core.sh
${SOURCE} ${COMPONENTS_PATH}/dev.sh
${SOURCE} ${COMPONENTS_PATH}/utils.sh
${SOURCE} ${COMPONENTS_PATH}/x-related.sh
${SOURCE} ${COMPONENTS_PATH}/hardware-drivers.sh
${SOURCE} ${COMPONENTS_PATH}/misc.sh
${SOURCE} ${COMPONENTS_PATH}/misc-gui.sh
${SOURCE} ${COMPONENTS_PATH}/virtualbox.sh
${SOURCE} ${COMPONENTS_PATH}/battery-management.sh
${SOURCE} ${COMPONENTS_PATH}/font-and-gtk-theme.sh
${SOURCE} ${COMPONENTS_PATH}/sound-related.sh
${SOURCE} ${COMPONENTS_PATH}/file-manager.sh
${SOURCE} ${COMPONENTS_PATH}/machine-specific.sh
${SOURCE} ${COMPONENTS_PATH}/shell-and-term-related.sh
${SOURCE} ${COMPONENTS_PATH}/cron-jobs.sh
${SOURCE} ${COMPONENTS_PATH}/lock-screen-script-dependencies.sh
${SOURCE} ${COMPONENTS_PATH}/fs-snapshots.sh
${COMPONENTS_PATH}/link-files.sh

sync
sudo reboot
