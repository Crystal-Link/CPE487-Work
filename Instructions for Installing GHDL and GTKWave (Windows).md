# Instructions for Installing GHDL and GTKWave (Windows)

###### These instructions make use of [MSYS2](https://www.msys2.org/). If you wish to use another terminal environment for Windows, you should try looking up the GHDL and GTKWave packages for the package manager that you are using.

## 1. Setup environment:
  ***NOTE: If you have taken CPE 390 before and already have MSYS2 set up, skip to [Installing GHDL and GTKWave](#2-installing-ghdl-and-gtkwave)***
   1. The following MSYS2 setup instructions were taken from [@CPE390](https://github.com/StevensDeptECE/CPE390/blob/master/Course%20Documentation/Instructions%20for%20Installing%20VSCode.md).
       1. Install [MSYS2](https://www.msys2.org/), [Git](https://git-scm.com/downloads), in that particular order
          1. Run the following in `MSYS2 MinGW 64-bit`
             1. `pacman -S git nano make cmake mingw64/mingw-w64-x86_64-gcc mingw-w64-x86_64-gdb mingw-w64-x86_64-gcc mingw-w64-x86_64-toolchain mingw-w64-x86_64-zlib mingw-w64-x86_64-freetype mingw-w64-x86_64-glfw bison flex cgdb`
          2. Open the start menu, search for "environment variables". Edit the `PATH` environment variable to include the following in exactly this order AT THE BOTTOM:
             1. `C:\msys64\mingw64\bin`
             2. `C:\msys64\usr\bin`
          3. Edit `C:\msys64\msys2_shell.cmd`, uncommenting `rem set MSYS2_PATH_TYPE=inherit` by removing `rem` from the front of the line.
          4. I believe that the git-bash will pull your ssh keys from the other shells. If not, you do not need to generate multiple ssh keys, just copy-paste the keys between msys2/wsl/cmd/etc in the home directory (`~/.ssh` or `C:\Users\StevensUser\.ssh`)
             1. Make sure you copy-paste both the public and private keys (`.pub` version and the version with no extension).
          5. In git bash, replacing Atilla's information with yours:
             1. `git config --global user.name "Atilla The Duck"`
             2. `git config --global user.email "aduck@stevens.edu"`

## 2. Installing GHDL and GTKWave
   1. Open `MSYS2 MinGW 64-bit`
   2. Copy the installation command for [GHDL](https://packages.msys2.org/package/mingw-w64-x86_64-ghdl) and [GTKWave](https://packages.msys2.org/package/mingw-w64-x86_64-gtkwave?repo=mingw64) and run them in your MINGW64 terminal.
        1. As of writing, the `pacman` commands are as such:
            1. GHDL: `pacman -S mingw-w64-x86_64-ghdl-llvm`
            2. GTKWave: `pacman -S mingw-w64-x86_64-gtkwave`
   3. You are done! Just note that you will have to use GHDL and GTKWave commands within the MINGW64 terminal now.

## 3. Potential Issues with `pacman`
Recently, I have ran into an issue where `pacman` does not work at all and always returns the following errors:
```
error: mingw32: signature from "David Macek <david.macek.0@gmail.com>" is unknown trust
error: mingw64: signature from "David Macek <david.macek.0@gmail.com>" is unknown trust
error: msys: signature from "David Macek <david.macek.0@gmail.com>" is unknown trust
error: database 'mingw32' is not valid (invalid or corrupted database (PGP signature))
error: database 'mingw64' is not valid (invalid or corrupted database (PGP signature))
error: database 'msys' is not valid (invalid or corrupted database (PGP signature))
```
Looks like this was caused by a change in packagers as announced on https://www.msys2.org/news/ --> [2020-06-29 - new packagers](https://www.msys2.org/news/#:~:text=please%20tell%20us.-,2020%2D06%2D29%20%2D%20new%20packagers,-Alexey%20is%20stepping).
If you have this issue, please run the following commands in **the specified order** in `MSYS2 MinGW 64-bit`
  1. `pacman -Syu`
  2. `pacman -S msys2-keyring`
  3. `rm -r /etc/pacman.d/gnupg/`
  4. `pacman-key --init`
  5. `pacman-key --populate msys2`
  6. `pacman -Syuu`
