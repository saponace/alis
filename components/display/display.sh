#-------------------------------------------------
# Display management
#-------------------------------------------------

# Multi-monitor layout management
    install_package arandr autorandr
    # Warning: autostarting this causes screen to turn black for a second after it
    # initially turns on, to then set the appropriate layout
        create_finalize_startup_entry "Restore previously set monitor layout on this hardware" "autorandr --change"


# Color shifter, reduce blue emission
    install_package redshift
    create_link components/display/config/redshift.conf ${USER_HOME}/.config
    create_finalize_startup_entry "Adjust blue levels in screen output at night (Redshift needs a running geoclue agent to be able to query geoclue)" "/usr/lib/geoclue-2.0/demos/agent &; redshift-gtk &"
