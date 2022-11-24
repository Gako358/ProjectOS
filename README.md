# The kernel

```
runvm   # Calls QEMU with the necessary commands, uses sudo for enabling kvm

#### Inside QEMU
# insmod module/helloworld.ko   # Load the kernel module
# rmmod module/helloworld.ko    # Unload the module
#### C^A+X to exit

cd helloworld
bear -- make            # generate the compile_commands.json
vim helloworld.c        # Start editing!

# exit and then nix develop .# or just direnv reload
# to rebuild and update the runvm command
```

## Kernel Build

In order to do this in Nix a custom config file is generated, using a modified version of the configfile
derivation in the generic kernel builder, also known as the buildLinux function.
This was necessary as the default NixOS distribution defaults needed to be removed.
More documentation is inside the flake. A new package set called linuxDev is then added
as an overlay using `linuxPackagesFor`. The initial ram disk is built using the new `make-initrd-ng`.
It is called through its nix wrapper which safely copies the nix store packages needed over.
`Busybox` is included and the helloworld kernel module.

## Credits
This is based on [jordanisaacs](https://github.com/jordanisaacs/kernel-module-flake) flake, to get started with kernel modules.

