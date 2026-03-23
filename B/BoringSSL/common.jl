script = raw"""
cd ${WORKSPACE}/srcdir/boringssl*

mkdir build && cd build

cmake 
-GNinja \
-DCMAKE_INSTALL_PREFIX=${prefix} \
-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TARGET_TOOLCHAIN} \
-DCMAKE_BUILD_TYPE=Release \
-DBUILD_SHARED_LIBS=ON \
-DCMAKE_POSITION_INDEPENDENT_CODE=ON \
-DCMAKE_INSTALL_LIBDIR=${libdir} \
-DBORINGSSL_PREFIX=LS \
-DGO_EXECUTABLE=$(which go) \
..

ninja -j${nproc}

mkdir -p ${prefix}/include
mkdir -p ${libdir}

cp -r ../include/* ${prefix}/include/

                    
if [[ "${target}" == *mingw* ]]; then
cp crypto/crypto.dll ${libdir}/
cp ssl/ssl.dll ${libdir}/
else
cp crypto/libcrypto.${dlext} ${libdir}/
cp ssl/libssl.${dlext} ${libdir}/
fi

install_license ../LICENSE
"""

platforms = supported_platforms()

dependencies = Dependency[]
                                