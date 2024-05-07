const expect = @import("std").testing.expect;

test "optional type" {
    // オプショナル宣言
    var foo: ?i32 = null;

    // オプションの子型から
    foo = 1234;

    // オプショナルの子型にアクセスするには、コンパイル時のリフレクションを使用
    try comptime expect(@typeInfo(@TypeOf(foo)).Optional.child == i32);
}
