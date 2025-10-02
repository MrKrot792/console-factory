const std = @import("std");
const world_type = @import("world.zig");
const building = @import("building.zig");
const math = @import("math.zig");
const item = @import("item.zig");
const c = @cImport({
    @cInclude("ncurses.h");
});

const allocator_selector = @import("allocator_selector.zig");

pub fn main() !void {
    const allocator_info = allocator_selector.getAllocator();
    const allocator = allocator_info.allocator;

    defer if (allocator_info.is_debug) {
        switch (allocator_selector.debugDeinit()) {
            .leak => std.debug.print("You leaked memory dum dum\n", .{}),
            .ok => std.debug.print("No memory leaks. For now...\n", .{}),
        }
    };

    _ = c.initscr();

    var world: world_type.World = try .init(allocator);
    defer world.deinit();

    var world_old: world_type.World = try .init(allocator);
    defer world_old.deinit();

    var dimensions: math.uvec2 = .{0, 0};
    var frame: u32 = 0;

    var conv = building.Conveyor.init(null);

    conv.direction = .up;
    conv.item = null;
    world.setCellByPosition(.{15, 2}, conv);

    conv.direction = .down;
    conv.item = item.getItem(.copper);
    world.setCellByPosition(.{15, 3}, conv);

    while (true) {
        frame += 1;
        dimensions = .{@intCast(c.COLS), @intCast(c.LINES)};

        _ = c.erase();
        const pixels_per_screen: math.uvec2 = .{dimensions[0] / 3, dimensions[1]};

        for(world.data) |*value| {
            if (value.* == null) continue;

            value.*.?.tick(world_old, world);
        }

        @memcpy(world_old.data, world.data);

        // Rendering
        for (0..pixels_per_screen[1]) |y| {
            for (0..pixels_per_screen[0]) |x| {
                const cell = world.getCellByPosition(.{@intCast(x), @intCast(y)});
                _ = c.printw((if (cell == null) "   " else cell.?.getTexture()));
            }

            if(dimensions[0] / 3 * 3 != dimensions[0])
                _ = c.printw("\n");
        }

        // UI
        _ = c.mvprintw(0, 0, "Frame: %d", frame);
        std.debug.print("Frame: {d}\n", .{frame});

        _ = c.refresh();
        if(c.getch() == ' ')
            break;
    }

    _ = c.endwin();

    std.debug.print("Size was: {}x {}y\n", .{dimensions[0] / 3, dimensions[1]});
    return;
}
