install_bats:
    # Install bats core
    rm -rf /tmp/bats-core
    sudo rm -rf /usr/src/bats-core
    sudo git clone https://github.com/bats-core/bats-core.git /usr/src/bats-core
    git clone https://github.com/ztombol/bats-support tests/test_helper/bats-support
    git clone https://github.com/ztombol/bats-assert tests/test_helper/bats-assert
    sudo /usr/src/bats-core/install.sh /usr/local

test:
    clear && bats tests/test.bats -p -T --print-output-on-failure --verbose-run