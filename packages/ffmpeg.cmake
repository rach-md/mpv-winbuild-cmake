ExternalProject_Add(ffmpeg
    DEPENDS
        zlib
        libxml2
        dav1d
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        ${ffmpeg_hardcoded_tables}
        --enable-libdav1d
        --enable-libxml2
        --enable-schannel
        --disable-iconv
        --disable-doc
        --disable-programs
        --disable-debug
        --disable-postproc
        --disable-muxers
        --disable-devices
        --disable-bsfs
        --disable-mediafoundation
        --disable-cuda-llvm
        --disable-d3d12va
        --disable-filters
        --enable-filter=aresample,loudnorm
        --disable-protocols
        --enable-protocol=http,https
        --disable-demuxer=matroska
        --disable-encoders
        --enable-encoder=mjpeg,png
        ${ffmpeg_lto}
        --extra-cflags='-Wno-error=int-conversion'
        "--extra-libs='${ffmpeg_extra_libs}'" # -lstdc++ / -lc++ needs by libjxl and shaderc
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
