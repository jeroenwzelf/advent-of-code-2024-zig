const std = @import("std");

pub fn read_args(comptime a: fn () anyerror![]const u8, comptime b: fn () anyerror![]const u8) !void {
    const allocator = std.heap.page_allocator;

    var argsIterator = try std.process.ArgIterator.initWithAllocator(allocator);
    defer argsIterator.deinit();

    _ = argsIterator.next();

    var arg_given = false;
    while (argsIterator.next()) |puzzle| {
        arg_given = true;
        if (std.mem.eql(u8, puzzle, "a")) {
            try run_puzzle("a", a);
        } else if (std.mem.eql(u8, puzzle, "b")) {
            try run_puzzle("b", b);
        }
    }

    // Run all when no args given
    if (!arg_given) {
        try run_puzzle("a", a);
        try run_puzzle("b", b);
    }
}

fn run_puzzle(comptime name: []const u8, comptime puzzle: fn () anyerror![]const u8) !void {
    const stdout = std.io.getStdOut().writer();

    try stdout.print("{s}: ", .{name});
    try stdout.print("{s}\n", .{try puzzle()});
}
