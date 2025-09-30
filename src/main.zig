const std = @import("std");
const world_type = @import("world.zig");
const building = @import("building.zig");
const math = @import("math.zig");
const c = @cImport({
    @cInclude("ncurses.h");
});

const allocator_selector = @import("allocator_selector.zig");

pub fn main() !void {
    const allocator_info = allocator_selector.get_allocator();
    const allocator = allocator_info.allocator;

    defer if (allocator_info.is_debug) {
        switch (allocator_selector.debug_deinit()) {
            .leak => std.debug.print("You leaked memory dum dum\n", .{}),
            .ok => std.debug.print("No memory leaks. For now...\n", .{}),
        }
    };

    _ = c.initscr();

    const world: world_type.world = try .init(allocator);
    defer world.deinit();

    var dimensions: math.uvec2 = .{0, 0};
    var frame: u32 = 0;

    world.set_cell_by_position(.{15, 2}, building.conveyor.init());

    while (true) {
        frame += 1;
        dimensions = .{@intCast(c.COLS), @intCast(c.LINES)};

        _ = c.erase();
        const pixels_per_screen: math.uvec2 = .{dimensions[0] / 3, dimensions[1]};

        // Rendering
        for (0..pixels_per_screen[1]) |y| {
            for (0..pixels_per_screen[0]) |x| {
                const cell = world.get_cell_by_position(.{@intCast(x), @intCast(y)});
                _ = c.printw((if (cell == null) "   " else cell.?.get_texture()));
            }

            if(dimensions[0] / 3 * 3 != dimensions[0])
                _ = c.printw("\n");
        }

        // UI
        _ = c.mvprintw(0, 0, "Frame: %d", frame);

        _ = c.refresh();
        if(c.getch() == ' ')
            break;
    }

    _ = c.endwin();

    std.debug.print("Size was: {}x {}y\n", .{dimensions[0] / 3, dimensions[1]});
}
