#!/bin/sh

echo "running dawin setup script"
DIR=$(cd $(dirname $0)/..; pwd -P)

ETC_DIR=/etc/tund
#BIN_DIR=/usr/local/bin
BIN_DIR=/usr/local/libexec #according to apple docs
LAUNCH_DAEMON_DIR=/Library/LaunchDaemons

# Install tund binary
if [ -d ${BIN_DIR} ]
  then
    install -m 700 -o root -g wheel "${DIR}/bin/tund" "${BIN_DIR}/tund"
  else
    mkdir -p ${BIN_DIR}
    install -m 700 -o root -g wheel "${DIR}/bin/tund" "${BIN_DIR}/tund"
fi

# Install launchDaemon
install -m 644 -o root -g wheel "${DIR}/osx/osxtund.plist" "${LAUNCH_DAEMON_DIR}/tund.plist"

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

# Install config file
install -m 600 -o root -g wheel "${DIR}/etc/tundconf.yaml" "${ETC_DIR}/tundconf.yaml"

# service tund start
launchctl load /Library/LaunchDaemons/tund.plist
