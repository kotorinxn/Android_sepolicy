#!/bin/zsh
echo "unpack img"
mv ./android/BOOT.img ./android/boot.img
if 
    ~/android-unpackbootimg/unpackbootimg -i ./android/boot.img -o ./android
then
else
    echo "error 0"
    exit 0
fi
echo "unpack gz"
cd ./android
if 
    gzip -d boot.img-ramdisk.gz
then
else
    echo "error 1"
    exit 0
fi
echo "unpack cpio"
if
    cpio -idvm < boot.img-ramdisk 
then
else
    echo "error 2"
    exit 0
fi
echo "cp sepolicy"
cd ../
if 
    cp ./android/sepolicy ./
then
else
    echo "error 3"
    exit 0
fi
echo "sesearching..."
if 
    ./sesearch --all sepolicy > sepolicy.txt
then
else
    echo "error 4"
    exit 0
fi
if 
    ./seinfo -xl --attribute sepolicy > seinfo.txt
then
else
    echo "error 5"
    exit 0
fi
cd android
rm -rf *