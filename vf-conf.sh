#!/bin/bash
# Execute as root or sudo, otherwise this will not work
currentid=$(id -u)
if [ "$currentid" != 0 ]; then
  echo "Please run this script as root/sudo."
  exit 1
fi

echo "Creating Haxelib directory for the portage user."
mkdir -p /var/tmp/portage/.local/share/haxe/
cp -r /usr/share/haxe/lib /var/tmp/portage/.local/share/haxe
echo "Done. The portage user's Haxelib directory is now /var/tmp/portage/.local/share/haxe/lib."
