#-------------------------------------------------
# Command line utilities
#-------------------------------------------------


# Files management
    # Distant and local copy
        ${INSTALL} rsync
    # Delete duplicates files
        ${INSTALL} rmlint
    # Downloads from the web
        ${INSTALL} wget
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
    # NTFS filesystems management
        ${INSTALL} ntfs-3g

# Misc
    # Git
        ${INSTALL} git
    # SSH client and server
        ${INSTALL} ssh
    # Mount distant directories over ssh
        ${INSTALL} sshfs
    # Access X clipboard from shell
        ${INSTALL} xclip
