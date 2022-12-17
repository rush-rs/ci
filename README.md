# rush CI Runners

This repository contains various docker images for running rush CI tests.

The main image can be found in the
[`runner`](https://github.com/rush-rs/ci/tree/main/runner) directory. It
contains a Rust, LLVM, Wasmtime, GCC, and RISC-V toolchain installation.
Therefore, the required software for running the rush integration tests is present.
