const std = @import("std");
const util = @import("util.zig");

const input = @embedFile("input/day01.txt");

pub fn main() !void {
    try util.read_args(a, b);
}

pub fn a() ![]const u8 {
    const line_len = 14;

    const input_len = input.len / line_len;

    var left_array: [input_len]u32 = undefined;
    var right_array: [input_len]u32 = undefined;

    for (0..input_len) |i| {
        const line_start = i * line_len;
        left_array[i] = try std.fmt.parseInt(u32, input[line_start .. line_start + 5], 10);
        right_array[i] = try std.fmt.parseInt(u32, input[line_start + 8 .. line_start + 13], 10);
    }

    std.mem.sort(u32, &left_array, {}, comptime std.sort.asc(u32));
    std.mem.sort(u32, &right_array, {}, comptime std.sort.asc(u32));

    var total_distance: u32 = 0;
    for (0..input_len) |i| {
        const distance =
            if (left_array[i] >= right_array[i]) left_array[i] - right_array[i] else right_array[i] - left_array[i];

        total_distance += distance;
    }

    var buffer: [64]u8 = undefined;
    const result = try std.fmt.bufPrint(&buffer, "{d}", .{total_distance});

    return try std.heap.page_allocator.dupe(u8, result);
}

pub fn b() ![]const u8 {
    return "";
}

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
