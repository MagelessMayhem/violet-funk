# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: hxcpp.eclass
# @MAINTAINER:
# Sebastian France <MagelessMayhem@protonmail.com>
# @AUTHOR:
# Sebastian France <MagelessMayhem@protonmail.com>
# @SUPPORTED_EAPIS: 8
# @BLURB: convenience eclass for HXCPP 
# @DESCRIPTION:
# The HXCPP eclass provides handling for the HaXe CPP Compiler (HXCPP), including setting threads and the like.
# This is necessary due to HXCPP's unique handling of compiler flags.

case ${EAPI} in
	8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

if [[ ! ${_HXCPP_ECLASS} ]]; then
_HXCPP_ECLASS=1

fi

BDEPEND="dev-lang/haxe"

# @ECLASS_VARIABLE: HXCPP_LIME_TARGET
# @DESCRIPTION:
# A variable which defines the build target for Lime, the primary project manager for Haxe.
# Lime uses the value of this variable to pass appropriate compilation instructions to HXCPP.
# Available values are debug, final, and release.
# If this variable is left unset by the developer, release will be used.
: "${HXCPP_LIME_TARGET:=release}"

# @FUNCTION: hxcpp_src_prepare
# @DESCRIPTION:
# Exported function which runs necessary preparations for HXCPP in the src_prepare phase.
# The primary duty of this function is to set up compiler flags according to the user's preferences.
# HXCPP stores flags in XML format, so this step is necessary for proper compilation.
# This function should be called AFTER haxelib_src_prepare.

hxcpp_src_prepare() {
	# Check if the current directory contains HXCPP	
	if [[ -d "${S}/.haxelib/hxcpp" ]] ; then
		HXCPP_XML=$(find "${S}/.haxelib/hxcpp" -name common-defines.xml)
		if [[ ! -z "$HXCPP_XML" ]] ; then
			# Use sed magic to add compiler flags to HXCPP's main XML
			# If for whatever reason CFLAGS/CXXFLAGS aren't set, no magic will be used

			ORIGINAL_IFS="${IFS}"
			IFS=" "

			if [[ ! -z "${CFLAGS}" ]] ; then
				read -ra HXCPP_CFLAGS <<< "${CFLAGS}"
				for CFLAG in "${HXCPP_CFLAGS[@]}"; do
					sed -i "2 i \ <cflag value=\""${CFLAG}"\"\/>" ${HXCPP_XML}
				done
			fi
			if [[ ! -z "${CXXFLAGS}" ]] ; then
				read -ra HXCPP_CXXFLAGS <<< "${CXXFLAGS}"
				for CXXFLAG in "${HXCPP_CXXFLAGS[@]}"; do
					sed -i "2 i \ <cppflag value=\""${CXXFLAG}"\"\/>" ${HXCPP_XML}
				done
			fi

			IFS="${ORIGINAL_IFS}"
		else
			die "common-defines.xml was not found..."
		fi
	else
		die "HXCPP not found!"
	fi
}

# @FUNCTION: hxcpp_src_compile
# @DESCRIPTION:
# Exported function which executes src_compile with HXCPP and Lime.
# This function sets HXCPP_COMPILE_THREADS if the user has specified -jn in MAKEOPTS.

hxcpp_src_compile() {
	
	HXCPP_JOBS=$(echo ${MAKEOPTS} | tr -dc '0-9')
	if [[ ! -z ${HXCPP_JOBS} ]] ; then
		HXCPP_COMPILE_THREADS=${HXCPP_JOBS} haxelib run lime build linux -v -${HXCPP_LIME_TARGET}
	else
		haxelib run lime build linux -v -${HXCPP_LIME_TARGET}
	fi

}

EXPORT_FUNCTIONS src_prepare src_compile
