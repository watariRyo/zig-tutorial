const std = @import("std");
const expect = std.testing.expect;

const SliceTypeA = extern struct {
    len: usize,
    ptr: [*]u32,
};
const SliceTypeB = extern struct {
    ptr: [*]SliceTypeA,
    len: usize,
};
const AnySlice = union(enum) {
    a: SliceTypeA,
    b: SliceTypeB,
    c: []const u8,
    d: []AnySlice,
};

fn withFor(any: AnySlice) usize {
    const Tag = @typeInfo(AnySlice).Union.tag_type.?;
    inline for (@typeInfo(Tag).Enum.fields) |field| {
        // inline for` を使うと、関数は次のように生成される。
        if (field.value == @intFromEnum(any)) {
            return @field(any, field.name).len;
        }
    }
    // inline for`を使用する場合、コンパイラーはすべてのケースを知ることはできない。
    // 明示的な `unreachable` が必要なすべてのケースが処理されているとしてハンドルする
    unreachable;
}

fn withSwitch(any: AnySlice) usize {
    return switch (any) {
        // `inline else` を使うと、その関数は明示的に生成される。
        // コンパイラーは可能性のあるすべてのケースをチェックすることができる。
        inline else => |slice| slice.len,
    };
}

test "inline for and inline else similarity" {
    const any = AnySlice{ .c = "hello" };
    try expect(withFor(any) == 5);
    try expect(withSwitch(any) == 5);
}
