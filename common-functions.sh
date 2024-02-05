#-------------------------------------------------
# Common functions
#-------------------------------------------------


function install_package() {
    echo "Installing package(s): $@"
    yay -S --noconfirm --needed $@
}

# Link a file and make sure the directory of the link exists
# $1: The source file/directory from this repo's root (ex: components/package-manager/config/yay)
# $2: The target directory
function create_link (){
    source_path=$(readlink -f "$1")
    source_file_name=$(basename ${source_path})
    sudo rm -rf "$2/${source_file_name}"  # Remove existing file/directory with source name in the target (if it exists)
    sudo mkdir -p $2  # Create the dir structure (if it does not exist)
    sudo ln -snf ${source_path} $2/  # Create the link
}

# Link a file in both /home/$USER/ and /root/
# $1: The source file/directory from this repo's root (ex: components/package-manager/config/yay)
# $2: The target directory from /home/$USER and /root
function create_homedir_link (){
    create_link $1 ${USER_HOME}/${2}
    create_link $1 ${ROOT_HOME}/${2}
}


# Append instructions that the user should follow (after reboot) to finalize setup
# $1: Type of instruction
# $2: Content of the instruction
function create_manual_todo (){
    output_file="manual-configuration-instructions.txt"
    if [ ! -f ${output_file} ]; then
        echo -e "Follow these instructions to finalize configuration of the system:\n" > ${output_file}
    fi

    echo "$1: $2" >> ${output_file}
}

# Append entry for the script "finalize_startup" in a temp file.
# After alis is done executing, content of the temp file will be appended to finalize_startup
# $1: Entry comment
# $2: Entry command
function create_finalize_startup_entry (){
    echo -e "# $1\n    $2\n" >> ${FINALIZE_STARTUP_ENTRIES_TEMP_FILE}
}
