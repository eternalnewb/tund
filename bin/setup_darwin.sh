#!/bin/sh

echo "running faux dawin setup script"
# DIR=$(cd $(dirname $0)/..; pwd -P)

# ETC_DIR=/etc/tund
# BIN_DIR=/usr/local/bin

# # Install tund binary
# install -m 700 -o root -g root -D "${DIR}/bin/tund" "${BIN_DIR}/tund"

# # Install upstart script
# if [ -d "/etc/init" ]
# then
#   install -m 644 -o root -g root "${DIR}/etc/init/tund.conf" /etc/init/tund.conf
# else
#   install -m 755 -o root -g root "${DIR}/etc/init.d/tund" /etc/init.d/tund
#   update-rc.d tund defaults
# fi


# if [ ! -e "${ETC_DIR}/key" ]
# then
#   if [ ! -e "${DIR}/etc/key" ]
#   then
#     # Generate key
#     ssh-keygen -b 4096 -N "" -O clear -O permit-port-forwarding -t rsa -f "${DIR}/etc/key"
#     echo "Public key is"
#     cat "${DIR}/etc/key.pub"
#   fi

#   # Install key
#   install -m 600 -o root -g root -D "${DIR}/etc/key" "${ETC_DIR}/key"
# fi

# service tund start
