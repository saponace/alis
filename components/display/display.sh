#-------------------------------------------------
# Display management
#-------------------------------------------------

# Multi-monitor management
    ${INSTALL} xrandr arandr
# Color shifter, reduce blue emission
    ${INSTALL} redshift
    # Switch redshift state script
        create_link components/diplay/scripts/switch-redshift-state /usr/local/bin
