#-------------------------------------------------
# Command line utilities
#-------------------------------------------------


# Files management
    # Delete duplicates files
        ${INSTALL} rmlint
    # Zip
        ${INSTALL} unzip
        ${INSTALL} zip
    # Rar
        ${INSTALL} unrar

# Monitoring and discovery
    # Network discovery tool
        ${INSTALL} nmap
    # List open files by given process
        ${INSTALL} lsof
    # System monitor tool
        ${install} bashtop

# Filesystems and mounting
    # Android metia transfert protocol
        ${install} jmtpfs
    # Auto-mounting media disks daemon
        ${INSTALL} udiskie

# Misc
    # Mount distant directories over ssh
        ${INSTALL} sshfs
    # Access X clipboard from shell
        ${INSTALL} xclip
