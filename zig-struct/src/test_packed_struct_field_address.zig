const std = @import("std");
const expect = std.testing.expect;

const BitField = packed struct {
    a: u3,
    b: u3,
    c: u2,
};

var bit_field = BitField{
    .a = 1,
    .b = 2,
    .c = 3,
};

// この場合、非ABIアライメント・フィールドへのポインタがビット・オフセットに言及しているが、関数はABIアライメント・ポインタを期待しているため、関数barを呼び出すことができない。
// 非ABIアラインメント・フィールドへのポインタは、ホスト整数内の他のフィールドと同じアドレスを共有する
test "pointers of sub-byte-aligned fields share addresses" {
    try expect(@intFromPtr(&bit_field.a) == @intFromPtr(&bit_field.b));
    try expect(@intFromPtr(&bit_field.a) == @intFromPtr(&bit_field.c));
}
