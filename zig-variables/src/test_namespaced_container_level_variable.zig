const std = @import("std");
const expect = std.testing.expect;

test "namespaced container level variables" {
    try expect(foo() == 1235);
    try expect(foo() == 1236);
}

// コンテナ・レベルの変数は、構造体、ユニオン、列挙型、不透明型の内部で宣言することができる：
const S = struct {
    var x: i32 = 1234;
};

fn foo() i32 {
    S.x += 1;
    return S.x;
}
