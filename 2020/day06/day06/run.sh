#!/bin/sh

sdir=`dirname $0`
cat "$sdir"/adv-cal.txt

if command -v qemu-system-i386 >/dev/null 2>&1; then
    QEMU=qemu-system-i386
elif command -v qemu-system-x86_64 >/dev/null 2>&1; then
    QEMU=qemu-system-x86_64
else
    cat <<EOF

Error: unable to find qemu-system-i386.
1. Try installing the qemu-system-i386 package on Fedora/RHEL
   or qemu-system on Debian-based distros.
2. Or compile QEMU from source:
   git clone https://git.qemu.org/git/qemu.git
   cd qemu && ./configure --target-list=x86_64-softmmu && make
   export PATH=\$PWD/i386-softmmu:\$PATH
EOF
    exit 1
fi

exec $QEMU -net none \
           -drive file="$sdir"/bootmine.img,format=raw,if=floppy
