#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Java Development Kit
    ${INSTALL} jdk7-openjdk openjdk7-doc
    ${INSTALL} jdk8-openjdk openjdk8-doc
    # Make JRE the default JRE
        sudo su -c "echo 'JAVA_HOME=/usr/lib/jvm/java-8-openjdk' >> /etc/environment"
# Java build tools
    ${INSTALL} maven
# IDEs
    ${INSTALL} intellij-idea-ultimate-edition
