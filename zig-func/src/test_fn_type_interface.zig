// 関数のパラメータは、型の代わりにanytypeを指定して宣言することができる。
// この場合、パラメータ型は関数呼び出し時に推論される。推論された型に関する情報を得るには、@TypeOfと@typeInfoを使用します。

const expect = @import("std").testing.expect;

fn addFortyTwo(x: anytype) @TypeOf(x) {
    return x + 42;
}

test "fn type inference" {
    try expect(addFortyTwo(1) == 43);
    try expect(@TypeOf(addFortyTwo(1)) == comptime_int);
    const y: i64 = 2;
    try expect(addFortyTwo(y) == 44);
    try expect(@TypeOf(addFortyTwo(y)) == i64);
}
