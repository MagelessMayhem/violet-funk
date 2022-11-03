# LarryTheFunker
Gentoo ebuild repository based around FNF and FNF mods.

If you're using this repository you should use the haxe ebuild this repository requires; it is simply ditto of Gentoo's ebuild except it pulls in the latest git instead of `haxe-debian`, which would otherwise ignore the legitimacy of haxelib. All FNF ebuilds pull this ebuild in by default.

To install the needed Haxe dependencies for the ebuilds in this overlay, execute `ltf-haxelib.sh` as root or under sudo.

After you've installed the necessary dependencies/libraries, you'll need to create the necessary haxelib directory for the portage user. You can simply execute `ltf-conf.sh` as root or under sudo to automate this. To make it easier on yourself, `ltf-conf.sh` automatically symlinks itself to `/usr/bin/ltf-conf` so you can simply use `ltf-conf` any time Portage removes the haxelib directory.

If Portage yells at you about the custom `funkin-mods` category, just use, as root (meaning inside of sudo -s) `echo "funkin-mods" > /etc/portage/categories`.

Almost forgot about installation (whoops). To install this repository to your system, simply have `app-eselect/eselect-repository` installed and use:

`sudo eselect repository add LarryTheFunker git https://github.com/MagelessMayhem/LarryTheFunker`

`sudo emerge --sync LarryTheFunker`
