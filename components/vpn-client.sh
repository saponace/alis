#-------------------------------------------------
# Configure VPN client
#-------------------------------------------------


${INSTALL} piavpn-bin

sudo systemctl enable piavpn.service

# MANUAL-TODO: In "Private internet Access" app (accessible via system tray icon), log in with PIA credentials, and enable "General>Connect on Launch"
