#!/bin/bash
# Execute as sudo/root, otherwise this will not work
# Make sure to execute vf-conf.sh after this to create the portage directory
haxelib setup /usr/share/haxe/lib
haxelib install newgrounds
haxelib install lime
haxelib install flixel
haxelib install flixel-ui
haxelib install hscript
haxelib install hxcpp
haxelib git flixel-addons https://github.com/HaxeFlixel/flixel-addons
haxelib git polymod https://github.com/larsiusprime/polymod.git
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git hxCodec https://github.com/polybiusproxy/hxCodec
haxelib run lime rebuild hxCodec linux
haxelib install flxanimate
haxelib install openfl
haxelib install actuate
haxelib run lime setup flixel
haxelib install flixel-tools
haxelib run flixel-tools setup
haxelib git linc_luajit https://github.com/nebulazorua/linc_luajit.git
haxelib git hxvm-luajit https://github.com/nebulazorua/hxvm-luajit
haxelib git faxe https://github.com/uhrobots/faxe
haxelib git extension-webm https://github.com/KadeDev/extension-webm
haxelib run lime rebuild extension-webm linux
haxelib git tentools https://github.com/TentaRJ/tentools
haxelib run lime rebuild tentools linux
haxelib git systools https://github.com/waneck/systools
haxelib run lime rebuild systools linux
echo "If any ebuild fails due to a polymod error, try an earlier version of polymod. Other than that, we're finished. I'll quit out of here."
