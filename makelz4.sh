#!/bin/sh

rm loader.bin loader.lz4

./fds -c loader.fds loader.bin
./lz4 -9 loader.bin loader.lz4
./bin2c loader.lz4 loader_lz4.c loader_lz4
