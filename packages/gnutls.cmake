ExternalProject_Add(gnutls
    DEPENDS
        nettle
        gmp
    GIT_REPOSITORY https://gitlab.com/gnutls/gnutls.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_SUBMODULES ""
    PATCH_COMMAND ${EXEC} git am --3way ${CMAKE_CURRENT_SOURCE_DIR}/gnutls-*.patch
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/bootstrap && CONF=1 <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --disable-cxx
        --disable-doc
        --disable-valgrind-tests
        --disable-manpages
        --disable-tests
        --disable-full-test-suite
        --disable-bash-tests
        --disable-seccomp-tests
        --disable-fuzzer-target
        --disable-oldgnutls-interop
        --disable-openssl-compatibility
        --disable-tls13-interop
        --disable-libdane
        --disable-ktls
        --disable-ssl3-support
        --disable-ssl2-support
        --disable-sha1-support
        --disable-dtls-srtp-support
        --disable-alpn-support
        --disable-ocsp
        --disable-srp-authentication
        --disable-psk-authentication
        --disable-dhe
        --disable-ecdhe
        --disable-gost
        --disable-anon-authentication
        --disable-heartbeat-support
        --disable-non-suiteb-curves
        --disable-fips140-mode
        --disable-strict-der-time
        --with-included-libtasn1
        --with-included-unistring
        --without-idn
        --without-p11-kit
        --without-tpm
        --without-tpm2
        --without-brotli
        --without-zstd
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(gnutls)
cleanup(gnutls install)
