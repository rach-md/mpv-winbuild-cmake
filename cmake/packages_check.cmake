if(COMPILER_TOOLCHAIN STREQUAL "gcc")
    set(ffmpeg_extra_libs "-lstdc++")
elseif(COMPILER_TOOLCHAIN STREQUAL "clang")
    set(ffmpeg_extra_libs "-lc++")
    set(mpv_lto_mode "-Db_lto_mode=thin")
    if(CLANG_PACKAGES_LTO)
        set(ffmpeg_lto "--enable-lto=thin")
        if(GCC_ARCH_HAS_AVX)
            set(zlib_lto "-DFNO_LTO_AVAILABLE=OFF")
            # prevent zlib-ng from adding -fno-lto
        endif()
    endif()
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
elseif(TARGET_CPU STREQUAL "i686")
    set(dlltool_image "i386")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
endif()
