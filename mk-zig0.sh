
# -O ReleaseSmall
ZIG_LIB_DIR=$PWD/lib zig build-exe --name zig0 --dep build_options -Mroot=./src/zig0.zig -Mbuild_options=src/zig0_build_options.zig
