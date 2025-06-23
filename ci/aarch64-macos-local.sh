#!/bin/sh

set -x
set -e

# Script assumes the presence of the following:
# s3cmd

ARCH="aarch64"

ZIGDIR="$PWD"
LOCDIR="$ZIGDIR/build-local"
TARGET="$ARCH-macos-none"
MCPU="baseline"
CACHE_BASENAME="zig+llvm+lld+clang-$TARGET-0.14.0-dev.1622+2ac543388"
PREFIX="$LOCDIR/$CACHE_BASENAME"

if [ ! -d "$PREFIX" ]; then
  mkdir -p $LOCDIR
  cd $LOCDIR
  curl -L -O "https://ziglang.org/deps/$CACHE_BASENAME.tar.xz"
  tar xf "$CACHE_BASENAME.tar.xz"
fi

cd $ZIGDIR

# Override the cache directories because they won't actually help other CI runs
# which will be testing alternate versions of zig, and ultimately would just
# fill up space on the hard drive for no reason.
export ZIG_GLOBAL_CACHE_DIR="$LOCDIR/zig-global-cache"
export ZIG_LOCAL_CACHE_DIR="$LOCDIR/zig-local-cache"

# Ensure that stage3 and stage4 are byte-for-byte identical.
zig014 build \
  --prefix /Users/qing/zig/zig014x \
  -Dflat \
  -Doptimize=ReleaseFast \
  -Dtarget=$TARGET \
  -Duse-zig-libcxx \
  --zig-lib-dir "$ZIGDIR/lib" \
  -Denable-llvm \
  -Dstatic-llvm \
  --search-prefix "$PREFIX"

  # -Dstrip \
  # -Dskip-non-native \
