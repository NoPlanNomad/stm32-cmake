A simple template to setup a cmake stm32 project
This template assumes the use of stm32f411CEU but can easily be changed for any stm32 MCU

## before use
1. rename project in cmakelist.txt
2. get a new linker script for your MCU
3. get a new startup script for your MCU
4. update CMakeLists.txt to use the new files
5. update the compiler and linkerflags if necessary
6. (optional) add [stm32cube-mcu-package](https://github.com/topics/stm32cube-mcu-package) as submodule
