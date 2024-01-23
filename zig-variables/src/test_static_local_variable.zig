// 関数内でコンテナを使用することで、静的寿命を持つローカル変数を持つことも可能です。
const std = @import("std");
const expect = std.testing.expect;

test "static local variable" {
    try expect(foo() == 1235);
    try expect(foo() == 1236);
}

// 関数内でコンテナを使用することで、静的寿命を持つローカル変数を持つことも可能
fn foo() i32 {
    const S = struct {
        var x: i32 = 1234;
    };
    S.x += 1;
    return S.x;
}
