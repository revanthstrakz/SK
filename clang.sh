#!/bin/bash
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

# Resources
THREAD="-j$(grep -c ^processor /proc/cpuinfo)"
KERNEL="Image"
DTBIMAGE="dtb"

DEFCONFIG="strakz_defconfig"


## Always ARM64
ARCH=arm64

## Always use all threads
THREADS=$(nproc --all)
export CLANG_PATH=~/gclang/bin
export PA"

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
		make $DEFCONFIG
		make ARCH=${ARCH} CC=clang -j${THREADS}

}

function make_zip {
		cd $REPACK_DIR
		mkdir kernel
		mkdir treble-supported
		mkdir treble-unsupported
		cp $KERNEL_DIR/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-nontreble.dtb $REPACK_DIR/treble-unsupported/
		cp $KERNEL_DIR/arch/arm64/boot/dts/qcom/msm8953-qrd-sku3-mido-treble.dtb $REPACK_DIR/treble-supported/
		cp $KERNEL_DIR/arch/arm64/boot/Image.gz $REPACK_DIR/kernel/
		zip -r9 `echo $ZIP_NAME`.zip *
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

