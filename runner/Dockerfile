FROM debian:buster

# install basic software
RUN apt update\
    && apt upgrade -y \
    && apt install llvm-dev build-essential curl\
    git tar software-properties-common -y

# add the LLVM apt repository
RUN apt-add-repository 'deb http://apt.llvm.org/buster/ llvm-toolchain-buster-14 main'\
    && curl https://apt.llvm.org/llvm-snapshot.gpg.key| apt-key add - && apt update

# install LLVM 14 and other packages using the older repos
RUN apt install llvm-14-dev libclang-common-14-dev zlib1g-dev -y

# install the RISCV toolchain since a newer version of it is required
RUN apt-add-repository 'deb http://deb.debian.org/debian bullseye main'\
    && apt update\
    && apt install binutils-riscv64-linux-gnu qemu-user -y

# configure Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:/root/wasmtime:$PATH

# install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > install.sh\
    && chmod +x install.sh \
    && ./install.sh -y \
    && rm install.sh

# download Wasmtime
RUN curl -OL https://github.com/bytecodealliance/wasmtime/releases/download/dev/wasmtime-dev-x86_64-linux.tar.xz \
    && tar xvf wasmtime-dev-x86_64-linux.tar.xz \
    && mv wasmtime-dev-x86_64-linux/wasmtime /usr/bin/ \
    && chmod +x /usr/bin/wasmtime

# update the `crates.io` index since it takes a lot of time
WORKDIR /root
RUN git clone https://github.com/rush-rs/rush
WORKDIR /root/rush
RUN cargo update

# copy the runner script
COPY run.sh /root/
RUN chmod +x /root/run.sh

# run the testing script by default
ENTRYPOINT ["/root/run.sh"]
