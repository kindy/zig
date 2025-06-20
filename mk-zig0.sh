
# usage:
# sh mk-zig0.sh -l
# sh mk-zig0.sh zig0 -- fetch --show-cache 'git+https://github.com/rockorager/libvaxis'
# sh mk-zig0.sh -Doptimize=ReleaseSafe
# sh mk-zig0.sh -Doptimize=ReleaseSmall

zig build --build-file build0.zig $@
