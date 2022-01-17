#-------------------------------------------------
# Display management
#-------------------------------------------------

# Arrange monitors layout
    ${INSTALL} arandr autorandr

# Color shifter, reduce blue emission
    ${INSTALL} redshift
    create_link components/display/config/redshift.conf ${USER_HOMEDIR_DOTFILES_DESTINATION}/.config
