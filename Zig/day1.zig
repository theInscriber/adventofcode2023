const std = @import("std");
const filesystem = std.fs;

fn parseString(string: []const u8) u8 {
    var first: ?u8 = null;
    var last: ?u8 = null;

    for (string) |value| {
        const parsedChar = value - '0';

        if (parsedChar < 0 or parsedChar > 9) continue;

        if (first == null) first = parsedChar;

        last = parsedChar;
    }

    if (last == null) return 0;

    const buffer = [_]u8{ std.fmt.digitToChar(first.?, .lower), std.fmt.digitToChar(last.?, .lower) };

    return std.fmt.parseUnsigned(u8, &buffer, 10) catch return 0;
}

pub fn main() !void {

    // Read the input
    var calibrations = try filesystem.cwd().openFile("day1.txt", .{});
    defer calibrations.close();

    var buffered_reader = std.io.bufferedReader(calibrations.reader());
    var ifs = buffered_reader.reader();

    // Loop through the buffer
    var buffer: [1024]u8 = undefined;
    var sum: u32 = 0;

    while (try ifs.readUntilDelimiterOrEof(&buffer, '\n')) |value| {
        sum += parseString(value);
    }

    try std.io.getStdOut().writer().print("The sum of calibration values: {d} \n", .{sum});
}
