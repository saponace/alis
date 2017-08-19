#-------------------------------------------------
# Common functions
#-------------------------------------------------

# Link a file and make sur the directory of the link exists
# $1: The source file
# $2: The target directory
function create_link (){
    sudo mkdir -p $2
    sudo ln -snf $(readlink -f "$1") $2
}
