#!/bin/bash
# Execute as root or sudo, otherwise this will not work
echo "Creating Haxelib directory for the portage user."
sleep 1
mkdir -p /var/tmp/portage/.local/share/haxe/
cp -r /usr/share/haxe/lib /var/tmp/portage/.local/share/haxe
echo "Symlinking ltf-conf to /usr/bin."
sleep 1
ln -s /var/db/repos/LarryTheFunker/ltf-conf.sh /usr/bin/ltf-conf
chmod +x /usr/bin/ltf-conf
echo "Done."
