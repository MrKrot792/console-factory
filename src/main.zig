const std = @import("std");
const world = @import("world.zig");
const math = @import("math.zig");
const c = @cImport({
    @cInclude("ncurses.h");
});

const allocator_selector = @import("allocator_selector.zig");

pub fn main() !void {
    // const allocator_info = allocator_selector.get_allocator();
    // const allocator = allocator_info.allocator;
    //
    // defer if (allocator_info.is_debug) {
    //     switch (allocator_selector.debug_deinit()) {
    //         .leak => std.debug.print("You leaked memory dum dum\n", .{}),
    //         .ok => std.debug.print("No memory leaks. For now...\n", .{}),
    //     }
    // };

    _ = c.initscr();

    var dimensions: math.uvec2 = .{0, 0};
    //const camera_position: math.vec2 = .{0, 0};

    while (true) {
    dimensions = .{@intCast(c.COLS), @intCast(c.LINES)};
        _ = c.erase();
        const pixels_per_screen: math.uvec2 = .{dimensions[0] / 3, dimensions[1]};
        for (0..pixels_per_screen[1]) |_| {
            for (0..pixels_per_screen[0]) |_| {
                _ = c.printw("[ ]");
            }

            if(dimensions[0] / 3 * 3 != dimensions[0])
                _ = c.printw("\n");
        }

        _ = c.refresh();
        if(c.getch() == ' ')
            break;
    }

    _ = c.getch();
    _ = c.endwin();

    std.debug.print("Size was: {}x {}y\n", .{dimensions[0] / 3, dimensions[1]});
}


/// Example:
/// prev_multiple(61, 3) => 60
fn prev_multiple(x: u32, n: u32) u32 {
    return (x / n) * n;
}
