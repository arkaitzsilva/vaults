#!/bin/bash

arg=$1

function initialize {
    meson build --prefix=/usr
    result=$?

    if [ $result -gt 0 ]; then
        echo "Unable to initialize, please review log"
        exit 1
    fi

    cd build

    ninja

    result=$?

    if [ $result -gt 0 ]; then
        echo "Unable to build project, please review log"
        exit 2
    fi
}

case $1 in
"clean")
    sudo rm -rf ./build
    ;;
"generate-i18n")
    initialize
    ninja com.github.arkaitzsilva.vaults-pot
    ninja com.github.arkaitzsilva.vaults-update-po
    ;;
"install")
    initialize
    sudo ninja install
    sudo update-icon-caches /usr/share/icons/*
    ;;
"install-deps")
    output=$((dpkg-checkbuilddeps ) 2>&1)
    result=$?

    if [ $result -eq 0 ]; then
        echo "All dependencies are installed"
        exit 0
    fi

    replace="sudo apt install"
    pattern="(\([>=<0-9. ]+\))+"
    sudo_replace=${output/dpkg-checkbuilddeps: error: Unmet build dependencies:/$replace}
    command=$(sed -r -e "s/$pattern//g" <<< "$sudo_replace")

    $command
    ;;
"run")
    initialize
    ./com.github.arkaitzsilva.vaults "${@:2}"
    ;;
"debug")
    initialize
    G_MESSAGES_DEBUG=all ./com.github.arkaitzsilva.vaults "${@:2}"
    ;;
"uninstall")
    initialize
    sudo ninja uninstall
    sudo update-icon-caches /usr/share/icons/*
    ;;
*)
    echo "Usage:"
    echo "  ./app [OPTION]"
    echo ""
    echo "Options:"
    echo "  clean             Removes build directories (can require sudo)"
    echo "  generate-i18n     Generates .pot and .po files for i18n (multi-language support)"
    echo "  install           Builds and installs application to the system (requires sudo)"
    echo "  install-deps      Installs missing build dependencies"
    echo "  run               Builds and runs the application"
    echo "  uninstall         Removes the application from the system (requires sudo)"
    ;;
esac
