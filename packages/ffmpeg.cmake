ExternalProject_Add(ffmpeg
    DEPENDS
        zlib
        dav1d
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests/ref/fate"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        --enable-libdav1d
        --disable-iconv
        --disable-doc
        --disable-programs
        --disable-debug
        --disable-postproc
        --disable-muxers
        --disable-demuxer=matroska
        --disable-devices
        --disable-bsfs
        --disable-mediafoundation
        --disable-cuda-llvm
        --disable-d3d12va
        --disable-filters
        --enable-filter=aresample,dynaudnorm
        --disable-encoders
        --enable-encoder=mjpeg,png
        --disable-decoder=aac_fixed,ac3_fixed,mp1,mp2,mp3,mp3adu,mp3on4
        ${ffmpeg_lto}
        --extra-cflags='-Wno-error=int-conversion'
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
