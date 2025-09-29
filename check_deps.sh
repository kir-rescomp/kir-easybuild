#!/bin/bash
# save as check_deps.sh

TOOLCHAINS="foss/2023a GCC/12.3.0 GCCcore/12.3.0"

DEPS=(
    "pkgconf" "Xvfb" "Autotools" "CMake" "X11" "Mesa" "libGLU" 
    "cairo" "libreadline" "ncurses" "bzip2" "XZ" "zlib" "SQLite" 
    "PCRE2" "libpng" "libjpeg-turbo" "LibTIFF" "Java" "Tk" "cURL" 
    "libxml2" "GMP" "NLopt" "FFTW" "libsndfile" "ICU" "HDF5" 
    "UDUNITS" "GSL" "ImageMagick" "GLPK" "nodejs" "GDAL" "MPFR" 
    "libgit2" "OpenSSL"
)

for dep in "${DEPS[@]}"; do
    echo "=== $dep ==="
    eb --search "^$dep" 2>/dev/null | grep -E "(foss/2023a|GCC/12.3.0|GCCcore/12.3.0)" | head -3
done
