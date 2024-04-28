// deferは逆の順序で評価される。
const std = @import("std");
const expect = std.testing.expect;
const print = std.debug.print;

test "defer unwinding" {
    print("\n", .{});

    defer {
        print("1 ", .{});
    }
    defer {
        print("2 ", .{});
    }
    if (false) {
        defer {
            print("3 ", .{});
        }
    }
}
// 2 1 の順で出力され、3は出力されない
