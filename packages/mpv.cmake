ExternalProject_Add(mpv
    DEPENDS
        ffmpeg
        lcms2
        libass
        libiconv
        libjpeg
        luajit
        uchardet
        shaderc
        libplacebo
        spirv-cross
        libzimg
        zlib
    GIT_REPOSITORY https://github.com/mpv-player/mpv.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson <BINARY_DIR> <SOURCE_DIR>
        --prefix=${MINGW_INSTALL_PREFIX}
        --libdir=${MINGW_INSTALL_PREFIX}/lib
        --cross-file=${MESON_CROSS}
        --prefer-static
        -Doptimization=3
        -Db_lto=true
        ${mpv_lto_mode}
        -Dpdf-build=enabled
        -Dlua=enabled
        -Duchardet=enabled
        -Dlcms2=enabled
        -Ddirect3d=disabled
        -Dgl=disabled
        -Dvulkan=disabled
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ""
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(mpv strip-binary
    DEPENDEES build
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/mpv.exe
    COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/mpv.com
    COMMENT "Stripping mpv binaries"
)

ExternalProject_Add_Step(mpv copy-binary
    DEPENDEES strip-binary
    COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.exe                           ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.exe
    COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.com                           ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/mpv.com
    COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.pdf                           ${CMAKE_CURRENT_BINARY_DIR}/mpv-package/doc/manual.pdf
    COMMENT "Copying mpv binaries and manual"
)

set(RENAME ${CMAKE_CURRENT_BINARY_DIR}/mpv-prefix/src/rename.sh)
file(WRITE ${RENAME}
"#!/bin/bash
cd $1
GIT=$(git rev-parse --short=7 HEAD)
mv $2 $2-git-\${GIT}")

ExternalProject_Add_Step(mpv copy-package-dir
    DEPENDEES copy-binary
    COMMAND chmod 755 ${RENAME}
    COMMAND mv ${CMAKE_CURRENT_BINARY_DIR}/mpv-package ${CMAKE_BINARY_DIR}/mpv-${TARGET_CPU}${x86_64_LEVEL}-${BUILDDATE}
    COMMAND ${RENAME} <SOURCE_DIR> ${CMAKE_BINARY_DIR}/mpv-${TARGET_CPU}${x86_64_LEVEL}-${BUILDDATE}

    COMMENT "Moving mpv package folder"
    LOG 1
)

force_rebuild_git(mpv)
force_meson_configure(mpv)
cleanup(mpv copy-package-dir)
