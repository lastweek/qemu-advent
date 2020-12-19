#!/bin/sh

sdir=`dirname $0`
cat "$sdir"/README

# Check for QEMU
if command -v qemu-system-x86_64 >/dev/null 2>&1; then
    QEMU=qemu-system-x86_64
elif command -v qemu-system-i386 >/dev/null 2>&1; then
    QEMU=qemu-system-i386
else
    cat <<EOF
Error: unable to find qemu-system-x86_64 or qemu-system-i386.

1. Try installing the corresponding qemu-system package from your
   distribution.

2. Or compile QEMU from source:
   git clone https://gitlab.com/qemu-project/qemu.git
   cd qemu && ./configure --target-list=x86_64-softmmu && make
   export PATH=\$PWD/build:\$PATH
EOF
    exit 1
fi

export QEMU
exec $QEMU -hda visopsys-0.9-usb.img -nic model=pcnet
