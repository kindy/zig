const std = @import("std");
const builtin = std.builtin;

const zig_version: std.SemanticVersion = .{ .major = 0, .minor = 14, .patch = 2 };

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .target = target,
        .optimize = optimize,
        .name = "zig0",
        .root_source_file = b.path("src/zig0.zig"),
        .zig_lib_dir = b.path("lib"),
    });
    const exe_options = b.addOptions();
    exe.root_module.addOptions("build_options", exe_options);
    const version_string = b.fmt("{}", .{zig_version});
    const version = try b.allocator.dupeZ(u8, version_string);
    exe_options.addOption([:0]const u8, "version", version);

    const install = b.addInstallArtifact(exe, .{});
    b.getInstallStep().dependOn(&install.step);

    const run = b.addRunArtifact(exe);
    if (b.args) |args| {
        run.addArgs(args);
    }
    b.step("zig0", "run zig0").dependOn(&run.step);
}
