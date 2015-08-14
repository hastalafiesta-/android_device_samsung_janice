#!/bin/bash

echo -e '\0033\0143'

# Specify colors for shell
txtbld=$(tput bold)             # Bold
bldgrn=${txtbld}$(tput setaf 2) # Bold green
bldblu=${txtbld}$(tput setaf 4) # Bold blue
bldcya=${txtbld}$(tput setaf 6) # Bold cyan
normal='tput sgr0'

# Initialize
top_patches="$(cd `dirname $0`; pwd)"
top_build="$(dirname $top_patches)"

cd $top_build
repo="frameworks/av"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal

git fetch https://github.com/hastalafiesta/android_frameworks_av.git cm-12.1
git cherry-pick 9349047085619c350f883ff9debbf4dae6043f92
git cherry-pick dfd0056f955f7f31620c97b849d3a46742b1340a
git cherry-pick 6342be6e9ee84470f7c5f05a5a775a8f59c28562
git cherry-pick 5c405f2a18ed0e9584799210f2407f0b9e894131
git cherry-pick 7fea91d60f7fe701d6a933d5ca7527206ad50d14
git cherry-pick 95e23dc44b5310ca11f708ea596c5292ea5cfe9b
git cherry-pick 4b05c5bdc3ec16d100c94984066d21d4eeaa7c85


echo -e ""
echo -e ""

cd $top_build
repo="frameworks/native"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_frameworks_native-1.git cm-12.1
git cherry-pick f701ab05d5b999761e81b400374cdfe6589ca54b # STE Native
git cherry-pick 527e5ab00760ca8e06dbeb47de900004f0b622f1 # HWC V0

echo -e ""
echo -e ""

cd $top_build
repo="build"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_build.git cm-12.1
git cherry-pick f40d895d4c7a1c78dc610128adf6901b5840dc45
git cherry-pick cc112d21a587219474914832b6a5696ee217202b
git cherry-pick 3d919dc09c70659eda42ab87f9f85868f209212c
echo -e ""
echo -e ""

cd $top_build
repo="bionic"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_bionic.git cm-12.1
git cherry-pick 2eacb6af70c0d52907a45dd9742a84cacb19ae5e # Text relocation warnings
git cherry-pick 18ad45241825ce5c03a8de159303a014ef5c79fc # Enable NON PIE hal support

echo -e ""
echo -e ""

cd $top_build
repo="packages/services/Telecomm"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_packages_services_telecomm.git cm-12.1
git cherry-pick b219c3c4be2ea6ec75b5890d0f97fd9d4cd3b4b7

echo -e ""
echo -e ""

cd $top_build
repo="frameworks/base"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_frameworks_base.git cm-12.1
git cherry-pick d56453eddec2c409347044e1a4ccfe7daa25fac4
git cherry-pick 32535aa710b435c76a4d3c1f76c8edd984ed03b3
git cherry-pick 3b5a4fc81df62ce23f99acf64bc2f5142b8b3e89

echo -e ""
echo -e ""

cd $top_build
repo="system/core"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_system_core-1.git cm-12.1
git cherry-pick 66c5a724625d18c4f1cd3150a1e02544a4f8a0ed
git cherry-pick 3aae7f5bc0d17b958eb71a17fda3498fb26a1355
git cherry-pick 76bebe16bbc2891d8704cb1b6eac45cd3f805cb7

echo -e ""
echo -e ""

cd $top_build
repo="hardware/libhardware"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_hardware_libhardware.git cm-12.1
git cherry-pick 262120e95748b0bafce9902c641ff6266ed09323
git cherry-pick 6c542c34d5208b78a34e92b29c582fee8cbf00b9
git cherry-pick 4738cc99dbf71acec493e8a1ba4254747c57a025

echo -e ""
echo -e ""

cd $top_build
repo="hardware/libhardware_legacy"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_hardware_libhardware_legacy-1.git cm-12.1
git cherry-pick 18751f722e90a7761995209d9ce97c58f05a530e

echo -e ""
echo -e ""

cd $top_build
repo="frameworks/opt/telephony"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_frameworks_opt_telephony.git cm-12.1
git cherry-pick e1b54fe23769785b160acb361e18f91bedc69965

echo -e ""
echo -e ""

cd $top_build
repo="frameworks/opt/net/wifi"
echo -e "${bldblu}  Patching $repo .."
cd $top_build/$repo
$normal
git fetch https://github.com/hastalafiesta/android_frameworks_opt_net_wifi.git cm-12.1
git cherry-pick f2864d968922e082328153f8051d94836e87b6d9

echo -e ""
echo -e ""


echo -e "PATCHING COMPLETED!"

$normal
cd $top_build
