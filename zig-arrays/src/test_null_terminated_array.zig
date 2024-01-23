const std = @import("std");
const expect = std.testing.expect;

test "null terminated array" {
    // lenに対応するインデックスに値xのセンチネル要素を持つ配列を記述。この場合は0を設定
    const array = [_:0]u8{ 1, 2, 3, 4 };

    try expect(@TypeOf(array) == [4:0]u8);
    try expect(array.len == 4);
    try expect(array[4] == 0);
}
