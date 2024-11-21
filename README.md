# MiercolOS

MiercolOS is a simple operating system project designed to demonstrate basic OS development concepts.

## Authors
- [@shaunikm](https://github.com/shaunikm)
- [@EBarringer2](https://github.com/EBarringer2)

## Purpose and Usage

MiercolOS is an educational project that lets you dive into OS development. Running at ring 0, it gives you direct access to hardware and system resources.

## Prerequisites

- **Assembler**: `nasm`
- **Bootloader Tools**: `grub-pc-bin`, `grub-common`
- **Emulator**: `qemu`
- **Containerization**: `docker`

## Building MiercolOS

### Set Up the Build Environment

To set up the build environment using Docker, execute the following commands:

```sh
docker build -t miercolos-buildenv buildenv
docker run -it --rm -v $(pwd):/root/env miercolos-buildenv
```

### Build the Kernel

Compile the kernel with the following command:

```sh
make build-x86_64
```

### Run the Kernel

To run the kernel using QEMU, use the command below:

```sh
qemu-system-x86_64 -cdrom dist/x86_64/miercolOS.iso
```

## Current Status

- **Kernel**: Boots successfully, prints "hello world", and then hangs.
- **Bootloader**: Fully operational.

![MiercolOS Boot Screenshot](assets/bootloader.png?raw=true)

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.