#-------------------------------------------------
# Common functions
#-------------------------------------------------

# Link a file and make sur the directory of the link exists
# $1: The source file
# $2: The target directory
function create_link (){
    sudo mkdir -p $2
    sudo ln -snf $(readlink -f "$1") $2/
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
