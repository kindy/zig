# zdocs

zdocs is like `zig std`, but for all modules.

## examples

std
```bash
zdocs -Mstd

# src dev
zig run --name zdocs src/main.zig -- -Mstd
```

module (arg like zig build-exe)

```bash
zdocs -Mmarkdown=src/wasm/markdown.zig
```
