set_property(DIRECTORY PROPERTY EP_STEP_TARGETS download)
include(${PROJECT_SOURCE_DIR}/cmake/packages_check.cmake)
list(APPEND ep
    uchardet
    zlib
    libjpeg
    lcms2
    libpng
    libiconv
    luajit
    fribidi
    libxml2
    brotli
    freetype2
    harfbuzz
    libunibreak
    libass
    xxhash
    dav1d
    spirv-headers
    spirv-tools
    spirv-cross
    glslang
    vulkan-header
    vulkan
    libsdl2
    openal-soft
    shaderc
    fast_float
    libplacebo
    ffmpeg
    mpv
    mpv-packaging
)
foreach(package IN LISTS ep)
    if(NOT ${SINGLE_SOURCE_LOCATION} STREQUAL "")
        set(SOURCE_LOCATION "${SINGLE_SOURCE_LOCATION}/${package}")
    endif()
    include(${CMAKE_CURRENT_SOURCE_DIR}/${package}.cmake)
    set(SOURCE_LOCATION "")

    get_property(_git_repository TARGET ${package} PROPERTY _EP_GIT_REPOSITORY)
    if(_git_repository)
        list(APPEND repo ${package})
    endif()
endforeach()
list(LENGTH ep ep_length)
message(STATUS "Parsing ${ep_length} packages")

add_custom_target(update
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${update}
    COMMENT "Updating git repo"
)

add_custom_target(download
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${download}
)

add_custom_target(package-fullclean
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target ${fullclean}
    COMMENT "Remove all stamp files, reset git HEAD"
)
