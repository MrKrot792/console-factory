This is `console-factory`. There are no screenshots, because there is not much to show for now.

# How to build.
## Linux.
1. Install `zig`.
Example for debian-based distros:
```bash
sudo apt update # Updating your system 
sudo apt install zig
```

2. Install ncurses. 
Example for debian-based distros:
```bash
sudo apt update # Updating your system 
sudo apt install libncurses-dev
```

3. Compile the project.
```bash
zig build -Doptimize=ReleaseSmall
```
or
(not recommended)
```bash
zig build -Doptimize=ReleaseFast
```
4. Run the binary.
The location of the binary is usually in `./zig-out/bin/console_factory`.
You can also compile and run at the same time with:
```bash
zig build -Doptimize=ReleaseSmall run
```

## Windows.
***!Not tested!***
Make sure ncurses and zig is installed in your system, then run:
```bash
zig build -Doptimize=ReleaseSmall
```
It probably won't compile, but i do not have a way to test this, so open an issue and
we'll see what we can do.

# Contributing
Contributing is very appreciated! Your pull request is very likely to be merged.
Thanks for supporting open-source project!
