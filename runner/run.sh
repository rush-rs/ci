#!/bin/bash

# update the rush repository
cd /root/rush || exit 1
git pull

# compile x86 corelib
cd /root/rush/crates/rush-compiler-x86-64/corelib || exit 1
make libcore.a

# compile RISC-V corelib
cd /root/rush/crates/rush-compiler-risc-v/corelib || exit 1
make all

# run tests
cd /root/rush/samples/tests || exit 1
python3 main.py
