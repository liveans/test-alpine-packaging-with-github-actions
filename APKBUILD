# Contributor: Ahmet Ibrahim AKSOY <aaksoy@microsoft.com>
# Maintainer: Microsoft QUIC Team <quicdev@microsoft.com>
pkgname=libmsquic
pkgver=2.5.0
pkgrel=0
_clog=f13417108b0f77260baec4784cf104fb9aff7576
_gtest=6dae7eb4a5c3a169f3e298392bff4680224aa94a
_openssl3=330feef3dcb69d95cd752d54cb9254b366bdc7cf
pkgdesc="Cross-platform, C implementation of the IETF QUIC protocol, exposed to C, C++, C# and Rust."
url="https://github.com/microsoft/msquic"
arch="x86_64 armv7 aarch64"
license="MIT"
makedepends="cmake numactl-dev linux-headers lttng-ust-dev openssl-dev perl xz"
checkdepends="perf"
subpackages="$pkgname-dev $pkgname-doc"
source="msquic-$pkgver.tar.gz::https://github.com/microsoft/msquic/archive/6dfd86ad0cf951c9d3bdc3b69a3c45bde6385018.tar.gz
        clog-$_clog.tar.gz::https://github.com/microsoft/CLOG/archive/$_clog.tar.gz
        gtest-$_gtest.tar.gz::https://github.com/google/googletest/archive/$_gtest.tar.gz
        openssl3-$_openssl3.tar.gz::https://github.com/quictls/openssl/archive/$_openssl3.tar.gz
        "
builddir="$srcdir/msquic-$pkgver"

prepare() {
        default_prepare

        cd "$builddir/submodules"
        rm -rf clog googletest openssl openssl3 xdp-for-windows
        mv ../../CLOG-*/ clog/
        mv ../../googletest-*/ googletest/
        mv ../../openssl-*/ openssl3/
}

build() {
        cmake -B build \
                -DCMAKE_INSTALL_PREFIX=/usr \
                -DCMAKE_BUILD_TYPE=Release \
                -DQUIC_TLS=openssl3 \
                -DQUIC_ENABLE_LOGGING=true \
                -DQUIC_USE_SYSTEM_LIBCRYPTO=true \
                -DQUIC_BUILD_TOOLS=off \
                -DQUIC_BUILD_TEST=on \
                -DQUIC_BUILD_PERF=off
        cmake --build build
}

check() {
        build/bin/Release/msquictest --gtest_filter=ParameterValidation.ValidateApi
}

package() {
        DESTDIR="$pkgdir" cmake --install build
        rm -rf "$pkgdir"/usr/share/msquic/
        install -Dm644 LICENSE "$pkgdir"/usr/share/licenses/$pkgname/LICENSE
}
sha512sums="
2f62e9aaf8be417fbcd197a6d9deade6c10a76d7a73b62fd8e4ee9948f6df1a999e7c4f9ba4e7db083d4c8e6018b61a77bda2f3ed1f2da60164bd547d4127300  msquic-2.5.0.tar.gz
1eac9dc1227b003f65e736becc90ab455394f2982e6c1802508dfcd2b43bcbe6e718b1e6beaa7f6ffd0e7eb0b6a91ae94802b535388b50d25b1c78d666d7ad8d  clog-f13417108b0f77260baec4784cf104fb9aff7576.tar.gz
346e27117800265bc9519c7aea1e48484e212f0e0f5a9a560271c6a1b7a06521ad05ee241c794d63aa97b0afa6850e6711351e132ec7ef7b98c9354672bfa2d2  gtest-6dae7eb4a5c3a169f3e298392bff4680224aa94a.tar.gz
92c144cabc5fbff5f019cdcdad21ed5afebe4ee597ee28140b999b77c8d16d76d33b724104c8b7aa1eb7e7ee0f83b9759a6841477528cec2127e674ac75121dc  openssl3-330feef3dcb69d95cd752d54cb9254b366bdc7cf.tar.gz
"