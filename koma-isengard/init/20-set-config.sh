#!/bin/bash

if [ -d "/opt/kodi-server/share/kodi/portable_data/userdata" ]; then
echo "using existing datafiles"
else
echo "creating datafiles"
mkdir -p /opt/kodi-server/share/kodi/portable_data/userdata
sleep 5s
fi

if [ -f "/opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml" ]; then
echo "using existing advancedsettings.xml"
else
echo "creating advancedsettings.xml"
cp /root/advancedsettings.xml /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
fi

chown -R abc:abc /opt/kodi-server
chown -R abc:abc /config
chmod -R 755 /config


