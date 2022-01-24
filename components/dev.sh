#-------------------------------------------------
# Install developpment tools and utilities
#-------------------------------------------------


# Java Development Kit
    # Installing this JDK first will set it qs default JDK
    install_package jdk-openjdk openjdk-doc openjdk-src
    install_package jdk11-openjdk openjdk11-doc openjdk11-src
    install_package jdk8-openjdk openjdk8-doc openjdk8-src
# Java build tools
    install_package maven
# IDEs
    install_package intellij-idea-ultimate-edition
    create_manual_todo 'Development' 'Log in with Jetbrains account in app "Intellij IDEA"'
