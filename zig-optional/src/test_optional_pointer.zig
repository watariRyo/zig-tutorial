// オプショナル・ポインターはポインターと同じサイズであることが保証される。
// オプショナルのNULLはアドレス0であることが保証される。

const expect = @import("std").testing.expect;

test "optional pointers" {
    // ポインターはNULLにはできない。
    // NULLポインタが欲しい場合は、プレフィックス `?を使用する
    var ptr: ?*i32 = null;

    var x: i32 = 1;
    ptr = &x;

    try expect(ptr.?.* == 1);

    // オプショナル・ポインターは、値0がNULL値として使われるため通常のポインターと同じサイズである。
    try expect(@sizeOf(?*i32) == @sizeOf(*i32));
}
