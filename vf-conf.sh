#!/bin/bash
# Execute as root or sudo, otherwise this will not work
currentid=$(id -u)
if [ "$currentid" != 0 ]; then
  echo "Please run this script as root/sudo."
  exit 1
fi

echo "Creating Haxelib directory for the portage user."
sleep 1
mkdir -p /var/tmp/portage/.local/share/haxe/
cp -r /usr/share/haxe/lib /var/tmp/portage/.local/share/haxe
echo "Symlinking vf-conf to /usr/bin."
sleep 1
ln -s /var/db/repos/violet-funk/vf-conf.sh /usr/bin/vf-conf
chmod +x /usr/bin/vf-conf
echo "Done."
