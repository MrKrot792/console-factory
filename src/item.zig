const std = @import("std");

// So three tiers for now.
pub const items = enum {
    copper,
    iron,
    titan,
};

pub const item = struct {
    texture: u8,
    name: []const u8,
};

pub fn getItem(i: items) item {
    return switch (i) {
        .copper => item{.name = "Copper", .texture = 'C'},
        .iron   => item{.name = "Iron",   .texture = 'I'},
        .titan  => item{.name = "Titan",  .texture = 'T'},
    };
}
