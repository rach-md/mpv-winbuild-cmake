ExternalProject_Add(gnutls
    DEPENDS
        nettle
        gmp
    URL https://www.gnupg.org/ftp/gcrypt/gnutls/v3.8/gnutls-3.8.6.tar.xz
    URL_HASH SHA256=2e1588aae53cb32d43937f1f4eca28febd9c0c7aa1734fc5dd61a7e81e0ebcdd
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && CONF=1 <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --disable-cxx
        --disable-doc
        --disable-gtk-doc
        --disable-valgrind-tests
        --disable-manpages
        --disable-tools
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
        --disable-gost
        --disable-anon-authentication
        --disable-heartbeat-support
        --disable-non-suiteb-curves
        --disable-fips140-mode
        --disable-strict-der-time
        --disable-padlock
        --with-included-libtasn1
        --with-included-unistring
        --without-idn
        --without-p11-kit
        --without-tpm
        --without-tpm2
        --without-unbound-root-key-file
        --without-system-priority-file
        --without-brotli
        --without-zstd
        --without-zlib
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(gnutls install)
