cmake_minimum_required(VERSION 3.7)
project(canokey-ffs C)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -fno-omit-frame-pointer")

set(VIRTCARD ON CACHE BOOL "Enable VIRTCARD in core" FORCE)
set(USBD_PRODUCT_STRING "CanoKey FunctionFS")
add_subdirectory(canokey-core EXCLUDE_FROM_ALL)

file(GLOB_RECURSE SRC Src/*.c)

add_executable(canokey-ffs ${SRC}
        canokey-core/virt-card/device-sim.c
        canokey-core/virt-card/fabrication.c
        canokey-core/littlefs/bd/lfs_filebd.c)
target_include_directories(canokey-ffs SYSTEM PRIVATE canokey-core/virt-card canokey-core)
target_compile_options(canokey-ffs PRIVATE "-fsanitize=address")
target_compile_definitions(canokey-ffs PRIVATE HW_VARIANT_NAME="CanoKey FunctionFS")
find_package(Threads)
target_link_libraries(canokey-ffs general canokey-core "-fsanitize=address" Threads::Threads)
add_dependencies(canokey-ffs gitrev)
