#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Java Development Kit
    ${INSTALL} jdk8-openjdk openjdk8-doc openjdk8-src
    ${INSTALL} jdk11-openjdk openjdk11-doc openjdk11-src
    ${INSTALL} jdk-openjdk openjdk-doc openjdk-src
    # Make JRE17 the default JRE
        sudo archlinux-java set java-17-openjdk
# Java build tools
    ${INSTALL} maven
# IDEs
    ${INSTALL} intellij-idea-ultimate-edition

# Google app script command line client
    # ${INSTALL} npm
    # sudo npm install @google/clasp

# Node Version Manager
    # ${INSTALL} nvm
