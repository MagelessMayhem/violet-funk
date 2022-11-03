# LarryTheFunker
Gentoo ebuild overlay based around FNF and FNF mods.

Using this overlay is fairly easy. First install `app-eselect/eselect-repository` and issue the following commands to add the overlay to your system:

`sudo eselect repository add LarryTheFunker git https://github.com/MagelessMayhem/LarryTheFunker`

`sudo emerge --sync LarryTheFunker`

Next, merge this overlay's Haxe ebuild to merge the correct haxelib:

`sudo emerge --ask --autounmask=y =dev-lang/haxe-9999`

After Haxe has been merged, run `/var/db/repos/LarryTheFunker/ltf-haxelib.sh` and `/var/db/repos/LarryTheFunker/ltf-conf.sh` respectively. These scripts install the necessary Haxe libraries and create the directory the ebuilds use to build FNF and/or FNF mods.

After you've done all this, you're set! You can merge any FNF ebuild to your heart's content.
