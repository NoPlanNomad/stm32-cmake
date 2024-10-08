set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi-)

execute_process(
        COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
        OUTPUT_VARIABLE BINUTILS_PATH
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${CMAKE_C_COMPILER})
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)

set(CMAKE_OBJCOPY ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)




#set(CMAKE_SYSTEM_NAME               Generic)
#set(CMAKE_SYSTEM_PROCESSOR          arm)
#
## Some default GCC settings
## arm-none-eabi- must be part of path environment
#set(TOOLCHAIN_PREFIX                arm-none-eabi-)
#set(C_FLAGS                         "-fdata-sections -ffunction-sections --specs=nano.specs -Wl,--gc-sections")
#set(CPP_FLAGS                       "-fno-rtti -fno-exceptions -fno-threadsafe-statics")
#
## Define compiler settings
#set(CMAKE_C_COMPILER                ${TOOLCHAIN_PREFIX}gcc ${C_FLAGS})
#set(CMAKE_ASM_COMPILER              ${CMAKE_C_COMPILER})
#set(CMAKE_CXX_COMPILER              ${TOOLCHAIN_PREFIX}g++ ${C_FLAGS} ${CPP_FLAGS})
#set(CMAKE_OBJCOPY                   ${TOOLCHAIN_PREFIX}objcopy)
#set(CMAKE_SIZE                      ${TOOLCHAIN_PREFIX}size)
#
#set(CMAKE_EXECUTABLE_SUFFIX_ASM     ".elf")
#set(CMAKE_EXECUTABLE_SUFFIX_C       ".elf")
#set(CMAKE_EXECUTABLE_SUFFIX_CXX     ".elf")
#
#set(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
#
#set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)