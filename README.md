# piCoreGamePlayer
Modifications, patches and extensions to change piCorePlayer to a retro gaming station

## Abstract idea
I build a standard piCorePlayer box and added nice box, cover and sound environment in the kitchen area. After some time I setup a RetroPie in the living room. Then I just had the idea if I'm able to combine my piCorePlayer and retro gaming in the same place. Here is the result.

## High Level Design
Blocks to be used in the current architecture:
1) piCorePlayer 6.0.0
2) JiveLite
3) SDL1.2
4) VICE 3.4

## Dependencies from piCorePlayer
rpi-vc
rpi-vc-dev
libpng
libpng-dev
readline-dev
automake (to regenerate Makefiles after disabling VICE doc folder)
autoconf (to regenerate Makefiles after disabling VICE doc folder)
libasound
libasound-dev

## Dependencies to build VICE
(Hint: If you don't like to build on your own find some prebuild tcz in the release section in GitHub)
- xa
  - Get the source from here: http://www.floodgap.com/retrotech/xa/
  - I used xa-2.3.11 for this PoC.
  - Call 'make' to run the Makefile to start the build process
  - Follow the Tiny Core instructions[1] to build/install a xa.tcz package
  - You need xa only to compile VICE not to run it. So no need to install xa.tcz in onboot.lst or ignore it complete if you just install SDL and VICE binaries.
- SDL1.2
  - Get a RPI version from here: https://github.com/vanfanel/SDL-1.2.15-raspberrypi
  - Apply the patch in this GitHub project (patches/SDL-1.2.15.patch) to SDL source
  - Call './MAC_ConfigureSDL12-rpi2.sh && make' to start the build process
  - follow the Tiny Core instructions[1] to build/install a SDL.tcz package 
- VICE
  - Get the source from here: https://vice-emu.sourceforge.io/index.html#download
  - I used vice-3.4 for this PoC.
  - Apply the patch in this GitHub project (patches/vice-3.4.patch) to SDL source
  - depending on your free RAM ad SWAP you might have to add a swap partition. Otherwise the VICE build may break with a compiler error. After I added and activated 2GB it worked perfect. Please search and read Tiny Core documentation how to do this.
  - Call './configure --enable-x64 --enable-sdlui --disable-sdlui2 --disable-hwscale && make' to start the build process
  - follow the Tiny Core instructions[1] to build/install a vice.tcz package 
  
## Run C64 games with VICE
For the current state of development in this PoC I kill the JiveLite process (if running) to have full SDL framebuffer access. I'll write some more words in chapter below. Just to demonstrate the PoC do:
- ps -A | grep jivelite
- You'll find the jivelite process, the starter script and the grep call itself. Kill the first two.
- kill -9 <pid>
- Copy a C64 ROM (for sure one you ripped before from you own original buyed games...) to a folder on your RPI
- sudo SDL1_VIDEODRIVER="fbcon" x64 +truedrive <ROM.d64>
   
  
[1] http://tinycorelinux.net/corebook.pdf (page 73ff)