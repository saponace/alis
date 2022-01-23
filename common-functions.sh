#-------------------------------------------------
# Common functions
#-------------------------------------------------

# Link a file and make sur the directory of the link exists
# $1: The source file/directory
# $2: The target directory
function create_link (){
    source_path=$(readlink -f "$1")
    source_file_name=$(basename ${source_path})
    sudo rm -rf "$2/${source_file_name}"  # Remove existing file/directory with source name in the target (if it exists)
    sudo mkdir -p $2  # Create the dir structure (if it does not exist)
    sudo ln -snf ${source_path} $2/  # Create the link
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
