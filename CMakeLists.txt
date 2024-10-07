cmake_minimum_required(VERSION 3.29)

# TODO: change project name
project(stm32_cmake)

# Setup cmake module path and compiler settings
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
message("Build type: " ${CMAKE_bUILD_TYPE})

enable_language(C CXX ASM)
# Setting languages
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(PROJ_PATH ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_TOOLCHAIN_FILE arm-none-eabi-gcc)

# fix toolchain file ignored by including it
include(cmake/arm-none-eabi-gcc.cmake)
message(${CMAKE_C_COMPILER})

#Set Linker File
set(linker_script_src ${PROJ_PATH}/STM32F411CEUx_FLASH.ld)

add_executable(${PROJECT_NAME}
        startup_stm32f411xe.s
        src/main.c
        src/syscall.c
        src/sysmem.c
)

target_compile_options(${PROJECT_NAME} PRIVATE
        -mtune=cortex-m4
        -march=armv7e-m
        -mthumb
#        -mfpu=fpv4-sp-d16
        -mfloat-abi=soft

        -fdata-sections
        -ffunction-sections

        -Wall
        -Wextra
        -pedantic
        --specs=nosys.specs

        $<$<CONFIG:Debug>:-Og>
)

target_link_options(${PROJECT_NAME} PRIVATE
        -T${CMAKE_SOURCE_DIR}/STM32F411CEUx_FLASH.ld
        -mtune=cortex-m4
        -march=armv7e-m
        -mthumb
#        -mfpu=fpv4-sp-d16
        -mfloat-abi=soft
        --specs=nano.specs
        --specs=nosys.specs
        -lc
        -lm
        -Wl,-Map=${PROJECT_NAME}.map,--cref
        -Wl,--gc-sections
)

add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND arm-none-eabi-size ${PROJECT_NAME}
)

add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND arm-none-eabi-objcopy -O ihex ${PROJECT_NAME} ${PROJECT_NAME}.hex
        COMMAND arm-none-eabi-objcopy -O binary ${PROJECT_NAME} ${PROJECT_NAME}.bin
)
