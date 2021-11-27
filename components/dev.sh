#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Java Development Kit
    # Installing this JDK first will set it qs default JDK
    ${INSTALL} jdk-openjdk openjdk-doc openjdk-src
    ${INSTALL} jdk11-openjdk openjdk11-doc openjdk11-src
    ${INSTALL} jdk8-openjdk openjdk8-doc openjdk8-src
# Java build tools
    ${INSTALL} maven
# IDEs
    ${INSTALL} intellij-idea-ultimate-edition
