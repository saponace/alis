#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yay -S --noconfirm --needed"
COMPONENTS_PATH="./components"
LOG_FILE="./alis.log"


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &


USERNAME=$(whoami)
DOTFILES_SOURCE="dotfiles"
USER_HOMEDIR_DOTFILES_DESTINATION="/home/${USERNAME}"
ROOT_HOMEDIR_DOTFILES_DESTINATION="/root"
SYSTEMD_UNITS_DIRECTORY="/etc/systemd/system"


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

# Fetch lines that are flagged "MANUAL-TODO" in every file of the repository, and copy them in a file
function compile_manual_actions (){
  filename="manual-configuration-instructions.txt"
  echo -e "Follow these instructions to finalize configuration of the system:\n" > ${filename}
  grep --no-filename -r "^# MANUAL-TODO" . | sed 's/# MANUAL-TODO: \(.*\)/* \1\n/' >> ${filename}
}


source ./common-functions.sh


install_component package-manager
install_component networking
install_component vpn-client
install_component dev
install_component cli-utils
install_component display
install_component window-manager
install_component hardware-drivers
install_component desktop-apps
install_component virtualisation
install_component battery-management
install_component font-and-gtk-theme
install_component audio
install_component file-manager
install_component machine-specific
install_component shell-and-term-apps
install_component gdrive-sync
install_component music-production

compile_manual_actions

sync
sudo reboot
