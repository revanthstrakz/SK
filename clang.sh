#!/bin/bash
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'
function install_package {
echo "installing dependencies"


install-package ccache bc bash libncurses5-dev git-core gnupg flex bison gperf build-essential \
zip curl libc6-dev ncurses-dev binfmt-support libllvm-3.6-ocaml-dev llvm-3.6 llvm-3.6-dev llvm-3.6-runtime \
cmake automake autogen autoconf autotools-dev libtool shtool python m4 gcc libtool zlib1g-dev
}

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image"
DTBIMAGE="dtb"

DEFCONFIG="strakz_defconfig"


## Always ARM64
ARCH=arm64

## Always use all threads
THREADS=$(nproc --all)
export CLANG_PATH=~/SK/gclang/bin
export PATH=${CLANG_PATH}:${PATH}
export CLANG_TRIPLE=aarch64-linux-gnu-
export CROSS_COMPILE=~/SK/gcc/bin/aarch64-linux-android-
export CROSS_COMPILE_ARM32=~/SK/gcc32/bin/arm-linux-androideabi-


# Paths
KERNEL_DIR=`pwd`
mkdir ~/asshole
REPACK_DIR=~/asshole
PATCH_DIR=~
ZIP_MOVE=~/Android/kernel/AK-releases/
ZIMAGE_DIR=~/Android/kernel/EAS/arch/arm64/boot

# Functions

function make_kernel {
		echo
		make O=out $DEFCONFIG
		make O=out ARCH=${ARCH} CC=clang -j${THREADS}

}

function transfer() {

zipname="$(echo $1 | awk -F '/' '{print $NF}')";
url="$(curl -# -T $1 https://transfer.sh)";
printf '\n';
echo -e "Download $zipname at $url";
}

function make_zip {
		cd $REPACK_DIR
		mkdir kernel
		mkdir treble-supported
		mkdir treble-unsupported
		cp $KERNEL_DIR/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nontreble.dtb $REPACK_DIR/treble-unsupported/
		cp $KERNEL_DIR/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-treble.dtb $REPACK_DIR/treble-supported/
		cp $KERNEL_DIR/arch/arm64/boot/Image.gz $REPACK_DIR/kernel/
		zip -r9 `echo $ZIP_NAME.zip * 
                transfer "$ZIP_NAME.zip"
		cd $KERNEL_DIR
}

		
DATE_START=$(date +"%s")


echo -e "${green}"
echo "-----------------"
echo "Making STRAKZ Kernel:"
echo "-----------------"
echo -e "${restore}"


# Vars
BASE_AK_VER="SK-Legend"
DATE=`date +"%Y%m%d-%H%M"`
AK_VER="$BASE_AK_VER$VER"
ZIP_NAME="$AK_VER"-"$DATE"
export LOCALVERSION=~`echo $AK_VER`
export LOCALVERSION=~`echo $AK_VER`
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=REVANTH
export KBUILD_BUILD_HOST=STRAKZ

echo

make_kernel 
make_zip
DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo

