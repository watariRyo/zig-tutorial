const std = @import("std");
const expect = std.testing.expect;

const Small2 = union(enum) {
    a: i32,
    b: bool,
    c: u8,
};
// tagNameを使用すると、フィールド名を表すcomptime [:0]const u8値を返すことができる：
test "@tagName" {
    try expect(std.mem.eql(u8, @tagName(Small2.a), "a"));
}
