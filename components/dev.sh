#-------------------------------------------------
# Developpment tools and utilities
#-------------------------------------------------

# Java stuff
install_package jdk-openjdk openjdk-doc openjdk-src
install_package jdk11-openjdk openjdk11-doc openjdk11-src
install_package jdk17-openjdk openjdk11-doc openjdk11-src
sudo archlinux-java set java-17-openjdk # Set default Java version to 11
install_package maven

# IDE
install_package intellij-idea-ultimate-edition
create_manual_todo 'Development' 'Log in with Jetbrains account in app "Intellij IDEA"'

# Git stuff
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa # Generate ssh keypair

# Set remote connection to this repository as SSH instead of HTTPS
git remote set-url origin git@github.com:saponace/alis.git
create_manual_todo 'Git' 'Log into github.com and add a new SSH key (get the public key with `cat  ~/.ssh/id_rsa.pub | xclip`)'
create_manual_todo 'Git' 'Set default git default user name and email address with `git config --global user.email "EMAIL_ADDRESS"` and `git config --global user.name "FIRST_NAME LAST_NAME"`'
