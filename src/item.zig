const std = @import("std");

// So three tiers for now.
pub const Items = enum {
    copper,
    iron,
    titan,
};

pub const Item = struct {
    texture: u8,
    name: []const u8,
};

pub fn getItem(i: Items) Item {
    return switch (i) {
        .copper => Item{.name = "Copper", .texture = 'C'},
        .iron   => Item{.name = "Iron",   .texture = 'I'},
        .titan  => Item{.name = "Titan",  .texture = 'T'},
    };
}
