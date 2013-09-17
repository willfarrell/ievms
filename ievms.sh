#!/usr/bin/env bash

# Caution is a virtue.
set -o nounset
set -o errtrace
set -o errexit
set -o pipefail

# ## Gobal Variables

# The ievms version.
ievms_version="0.0.1"

# Options passed to each `curl` command.
curl_opts=${CURL_OPTS:-""}

# ## Utilities

# Download a URL to a local file. Accepts a name, URL and file.
# name, url, archive, md5
download() {
    if [[ -f "${3}" && `md5 -q ${3}` == ${4} ]]; then
        echo "1. Found ${1} at ${3} - skipping download"
    else
        echo "1. Downloading ${1} from ${2}"
        curl ${curl_opts} -O "${2}" || fail "Failed to download ${2} to ${ievms_home}/${3} using 'curl', error code ($?)"
    fi
}

# name (${file})
extract() {
    vm="${1}.vmwarevm"
    sfx="${1}${2}.sfx"
    if [[ -a "${vm}" ]]; then
        echo "2. Found ${vm} - skipping extraction"
    else
        echo "2. Extracting ${sfx} to ${vm}"
        # Allow file to be executable
        chmod +x ${sfx}
        
        # Extract files
        ./${sfx}
    fi
}

# ## General Setup

# Create the ievms home folder and `cd` into it. The `INSTALL_PATH` env variable
# is used to determine the full path. The home folder is then added to `PATH`.
create_home() {
    local def_ievms_home="${HOME}/Virtual Machines"
    ievms_home=${INSTALL_PATH:-$def_ievms_home}

    mkdir -p "${ievms_home}"
    cd "${ievms_home}"

    PATH="${PATH}:${ievms_home}"
}

# Check for a supported host system (Linux/OS X).
check_system() {
    kernel=`uname -s`
    case $kernel in
        Darwin|Linux) ;;
        *) fail "Sorry, $kernel is not supported." ;;
    esac
}

# Download and setup vm
build_ievm() {
    os=$2
    local vm="IE${1} - ${os}"
    local name="${vm/ - /_}"
    local file="IE${1}.${os}.For.MacVMware"
    local url="https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VMWare_Fusion/${name}/${file}"
    
    case $1 in
        6)
            if [ "${os}" == "XP" ]; then
                download "${name}" "${url}.sfx" "${file}.sfx" "f09cd5d442a0f1be09884553fc800443"
                extract "${file}" ""
            else
                build_ievm "6" "XP"
                return
            fi
            ;;
        7)
             if [ "${os}" == "Vista" ]; then
                download "${name}" "${url}.part01.sfx" "${file}.part01.sfx" "383b355c80761ba6a547b8411091969b"
                download "${name}" "${url}.part02.rar" "${file}.part02.rar" "350efb710d629b561fa2f9db1a27429b"
                download "${name}" "${url}.part03.rar" "${file}.part03.rar" "ee575a12e66538317bbcce1f3481c01a"
                download "${name}" "${url}.part04.rar" "${file}.part04.rar" "1148793473fae77ef9b8255c7e1c8af2"
                extract "${file}" ".part01"
            else
                build_ievm "7" "Vista"
                return
            fi
            ;;
        8)
            if [ "${os}" == "XP" ]; then
                download "${name}" "${url}.sfx" "${file}.sfx" "6525c81fc94eea0330212032cee8f53f"
                extract "${file}" ""
            elif [ "${os}" == "Win7" ]; then
                download "${name}" "${url}.part01.sfx" "${file}.part01.sfx" "52cac62c91d4f19ae31d3e401d494b73"
                download "${name}" "${url}.part02.rar" "${file}.part02.rar" "346959420647c531edb7bca6e8dbdf41"
                download "${name}" "${url}.part03.rar" "${file}.part03.rar" "aff7f529dd429475af6e3cd3612d8fb3"
                extract "${file}" ".part01"
            else
                build_ievm "8" "XP"
                build_ievm "8" "Win7"
                return
            fi
            ;;
        9)
            if [ "${os}" == "Win7" ]; then
                download "${name}" "${url}.part01.sfx" "${file}.part01.sfx" "b3bb8e50e91011253c072eb474357b04"
                download "${name}" "${url}.part02.rar" "${file}.part02.rar" "b9b75898ae4bc79ba6ef013774c53f2a"
                download "${name}" "${url}.part03.rar" "${file}.part03.rar" "723891d5cdd03a80d74adcd467755940"
                extract "${file}" ".part01"
            else
                build_ievm "9" "Win7"
                return
            fi
            ;;
        10)
            if [ "${os}" == "Win7" ]; then
                download "${name}" "${url}.part01.sfx" "${file}.part01.sfx" "5a59113ffb0b63b36146485b7c7c677f"
                download "${name}" "${url}.part02.rar" "${file}.part02.rar" "87df427499953cb97fee08bbd783b2cb"
                download "${name}" "${url}.part03.rar" "${file}.part03.rar" "ee15ebacf740ffb84aff6ad604661d87"
                download "${name}" "${url}.part04.rar" "${file}.part04.rar" "35ccb38fce5532b10c3d7ca6b2f782ad"
                extract "${file}" ".part01"
            elif [ "${os}" == "Win8" ]; then
                download "${name}" "${url}.part1.sfx" "${file}.part1.sfx" "d1728a47a82e404d3000115d497e2e06"
                download "${name}" "${url}.part2.rar" "${file}.part2.rar" "97ab7b0103d0b1d2816dfc6689c4db4e"
                download "${name}" "${url}.part3.rar" "${file}.part3.rar" "58543010219ce428496abbec51b032b4"
                extract "${file}" ".part1"
            else
                build_ievm "10" "Win7"
                build_ievm "10" "Win8"
                return
            fi
            ;;
        11)
            if [ "${os}" == "Win7" ]; then
                download "${name}" "${url}.part01.sfx" "${file}.part01.sfx" "34b9c080dde9b9e628fab230e78019f1"
                download "${name}" "${url}.part02.rar" "${file}.part02.rar" "3c23ea214dcb2ccd2912ed5f5b02923b"
                download "${name}" "${url}.part03.rar" "${file}.part03.rar" "70e7e63d9530807745de1202cb3fa4b5"
                download "${name}" "${url}.part04.rar" "${file}.part04.rar" "f1c4ad7a193088f259cbc39f1654bad4"
                extract "${file}" ".part01"
            elif [ "${os}" == "Win8.1" ]; then
                # Specail case for 8.1
                local name="IE11_Win81"
                os="Win8.1Preview"
                local file="IE${1}.${os}.For.MacVMware"
                local url="https://az412801.vo.msecnd.net/vhd/IEKitV1_Final/VMWare_Fusion/${name}/${file}"
                download "${name}" "${url}.part1.sfx" "${file}.part1.sfx" "0a43fdb7c731a9d8da074af9b7ff1414"
                download "${name}" "${url}.part2.rar" "${file}.part2.rar" "3979da0db83dae83d6f1ef59b3ab31ee"
                download "${name}" "${url}.part3.rar" "${file}.part3.rar" "3c62f4e6a9bf768521e3b23477f33281"
                extract "${file}" ".part1"
            else
                build_ievm "11" "Win7"
                build_ievm "11" "Win8.1"
                return
            fi
            ;;
        *) fail "Invalid IE version: ${1}" ;;
    esac
}

# ## Main Entry Point

echo "--------------------------------------"
echo "ievms - IE Virtual Machines for VMWare"
echo "--------------------------------------"

# Run through all checks to get the host ready for installation.
check_system
create_home

# Install each requested virtual machine sequentially.
all_versions="6 7 8 9 10 11"
for ver in ${IEVMS_VERSIONS:-$all_versions}
do
    echo "\nBuilding IE${ver} VM ----------------------"
    build_ievm $ver "ALL"
done

# We made it!
echo "Done!"