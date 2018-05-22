#!/bin/sh

qemu="qemu-system-x86_64 \
        -gdb tcp::1201 \
        -smp 1 \
        -curses \
        -m 1024 \
        -net nic \
        -net user,id=net0,hostfwd=tcp::10022-:22 \
        -drive file=/home/pleb//NetBSD-GSoC/vhd/netbsd-current.img,if=none,format=raw,id=id0 \
        -device ide-drive,drive=id0,serial=id0
	-enable-kvm
	"

#qemu-system-x86_64 -drive file=~/NetBSD-GSoC/vhd/netbsd-current.img,format=raw \
#-netdev user,id=net0,hostfwd=tcp::2222-:22 -device e1000,netdev=net0 -enable-kvm -nographic -s

if [ "$1" = "" ]; then
        $qemu
else
        $qemu \
        -drive file=./netbsd.$1.tar,if=none,id=id1,cache=writeback,format=raw \
        -device virtio-blk,drive=id1,serial=id1,bootindex=1
fi