pub const ivec2 = @Vector(2, i32);
pub const vec2 =  @Vector(2, f32);
pub const uvec2 = @Vector(2, u32);

pub const Direction = enum {
    up, down, right, left,
};

pub fn get_vector_by_direction(direction: Direction, comptime T: type) T {
    if (T == ivec2 or T == vec2) {
        return switch (direction) {
            .up    => .{ 0,  1 },
            .down  => .{ 0, -1 },
            .right => .{ 1,  0 },
            .left  => .{-1,  0 },
        };
    }
    else {
        unreachable;
    }
}

// pub fn get_string_by_direction(direction: Direction) u8 {
//     return switch (direction) {
//         .up    => '↑',
//         .down  => '↓',
//         .right => '→',
//         .left  => '←',
//     };
// }
