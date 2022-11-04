# violet-funk
Gentoo ebuild overlay based around FNF and FNF mods.

Using this overlay is fairly easy. First install `app-eselect/eselect-repository` and issue the following commands to add the overlay to your system:

`sudo eselect repository add violet-funk git https://github.com/MagelessMayhem/violet-funk`

`sudo emerge --sync violet-funk`

Next, merge this overlay's Haxe ebuild to merge the correct haxelib:

`sudo emerge --ask --autounmask=y =dev-lang/haxe-9999`

After Haxe has been merged, run `/var/db/repos/violet-funk/vf-haxelib.sh` and `/var/db/repos/violet-funk/vf-conf.sh` respectively. These scripts install the necessary Haxe libraries and create the directory the ebuilds use to build FNF and/or FNF mods.

After you've done all this, you're set! You can merge any FNF ebuild to your heart's content.

You may also run `python3 /var/db/repos/violet-funk/vf-perms.py` and select the directory of the game to gain ownership of the folder, which would allow you to execute it.
