#!/bin/sh

echo "running dawin setup script"
DIR=$(cd $(dirname $0)/..; pwd -P)

ETC_DIR=/etc/tund
BIN_DIR=/usr/local/bin
LAUNCH_DAEMON_DIR=/Library/LaunchDaemons
# TODO, change bin dir to /usr/local/libexec per Apple's instructions

# Install tund binary
# TODO check for whether directorory exists (non homebrew users?)
if [ -d ${BIN_DIR} ]
  then
    install -m 700 -o root -g wheel "${DIR}/bin/tund" "${BIN_DIR}/tund"
  else
    mkdir -p ${BIN_DIR}
    install -m 700 -o root -g wheel "${DIR}/bin/tund" "${BIN_DIR}/tund"
fi

# Install launchDaemon
# TODO install -m 700 -o root -g wheel "${DIR}/bin/tund" "${BIN_DIR}/tund"

if [ ! -e "${ETC_DIR}/key" ]
then
  if [ ! -e "${DIR}/etc/key" ]
  then
    # Generate key
    ssh-keygen -b 4096 -N "" -O clear -O permit-port-forwarding -t rsa -f "${DIR}/etc/key"
    echo "Public key is"
    cat "${DIR}/etc/key.pub"
  fi

  # Install key
  echo "Beginning key installation process..."
  echo "from ${DIR}/etc/key to ${ETC_DIR}/key"
  if [ -d ${ETC_DIR} ]
  then
    install -m 600 -o root -g wheel "${DIR}/etc/key" "${ETC_DIR}/key"
  else
    mkdir -p ${ETC_DIR}
    install -m 600 -o root -g wheel "${DIR}/etc/key" "${ETC_DIR}/key"
  fi
fi

# service tund start
echo "start launchDaemon here"
