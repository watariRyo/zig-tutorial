// あるポインタ型を別の型に変換するには、@ptrCastを使う。
// これはZigが保護できない安全でない操作。ptrCastは、他の変換が不可能な場合にのみ使用する

const std = @import("std");
const expect = std.testing.expect;

test "pointer casting" {
    const bytes align(@alignOf(u32)) = [_]u8{ 0x12, 0x12, 0x12, 0x12 };
    const u32_ptr: *const u32 = @ptrCast(&bytes);
    try expect(u32_ptr.* == 0x12121212);

    const u32_value = std.mem.bytesAsSlice(u32, bytes[0..])[0];
    try expect(u32_value == 0x12121212);

    try expect(@as(u32, @bitCast(bytes)) == 0x12121212);
}

test "pointer child type" {
    try expect(@typeInfo(*u32).Pointer.child == u32);
}
