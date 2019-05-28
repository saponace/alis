#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Java Development Kit
    ${INSTALL} jdk8-openjdk openjdk8-doc openjdk8-src
    ${INSTALL} jdk10-openjdk openjdk10-doc openjdk10-src
    # Make JRE the default JRE
        sudo su -c "echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk' >> /etc/environment"
# Java build tools
    ${INSTALL} maven
# IDEs
    ${INSTALL} intellij-idea-ultimate-edition
# Google app script command line client
    ${INSTALL} npm
    sudo npm install @google/clasp
