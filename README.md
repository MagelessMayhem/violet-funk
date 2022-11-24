# violet-funk

Gentoo ebuild overlay based around FNF and FNF mods.

All of the ebuilds in this overlay install pre-built binaries. You do not need to worry about compiling them (because trying to build with Haxe using Portage is a headache and a half).

This repository is now available in Gentoo's repositories.xml! To enable it, you can run either of these commands:

`sudo eselect repository enable violet-funk` (if you are using `app-eselect/eselect-repository`)

`sudo layman -a violet-funk` (if you are using `app-portage/layman`)

I accept (almost) any suggestions as to which mods to port and/or include in this overlay. You may open an issue with the mod to suggest ***granted it has accessible source code.*** Please include the link to the mod's source code when suggesting a mod.
