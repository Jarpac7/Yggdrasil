name = "BoringSSL"
version = v"2025.8.7"

sources = [
    ArchiveSource("https://github.com/google/boringssl/releases/download/0.20250807.0/boringssl-0.20250807.0.tar.gz",
             "0cd3a2ba242ead4b3365b8c66cfed4a5f3f0ae511e9c0fd627edee1252d3dbe2")
]

include("../common.jl")

products = [
    LibraryProduct(["libcrypto", "crypto"], :libcrypto),
    LibraryProduct(["libssl", "ssl"], :libssl)
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; 
              compilers=[:c, :go], julia_compat="1.6")
