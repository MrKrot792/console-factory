var debug_allocator: std.heap.DebugAllocator(.{}) = .init;
const builtin = @import("builtin");
const std = @import("std");

pub const allocator_information = struct {
    allocator: std.mem.Allocator,
    is_debug: bool,
};

pub fn get_allocator() allocator_information {
    const allocator, const is_debug = gpa: {
        break :gpa switch (builtin.mode) {
            .Debug, .ReleaseSafe => .{ debug_allocator.allocator(), true },
            .ReleaseFast, .ReleaseSmall => .{ std.heap.smp_allocator, false },
        };
    };

    return .{
        .allocator = allocator,
        .is_debug = is_debug,
    };
}

pub fn debug_deinit() std.heap.Check {
    return debug_allocator.deinit();
}
