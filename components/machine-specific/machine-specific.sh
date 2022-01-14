#-------------------------------------------------
# Configure machine specific settings
# Here, a thinkpad T550
#-------------------------------------------------


# Start and stop charging batteries at given values (preserve batteries health on the long term)
    ${INSTALL} tp-battery-mode
    sudo systemctl enable tp-battery-mode
# Get battery level script
    create_link components/machine-specific/scripts/battery-level /usr/local/bin
