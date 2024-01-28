// 整数アドレスをポインタに変換するには@ptrFromIntを使う。ポインタを整数に変換するには @intFromPtr を使う。

const expect = @import("std").testing.expect;

test "@intFromPtr and @ptrFromInt" {
    const ptr: *i32 = @ptrFromInt(0xdeadbee0);
    const addr = @intFromPtr(ptr);
    try expect(@TypeOf(addr) == usize);
    try expect(addr == 0xdeadbee0);
}
