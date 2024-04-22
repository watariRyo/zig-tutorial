// 匿名構造体はフィールド名を指定せずに作成でき、「タプル」と呼ばれる。

// フィールド名は暗黙的に0から始まる数字で命名される。フィールド名は整数であるため、
// @""でくくることなく.構文でアクセスすることはできない。""内の名前は常に識別子として認識される。

// 配列と同様、タプルは.lenフィールドを持ち、インデックスを付けることができ（インデックスがcomptime-knownであることが条件）、
// ++演算子や**演算子を使うことができる。また、インラインforで反復処理することもできる

const std = @import("std");
const expect = std.testing.expect;

test "tuple" {
    const values = .{
        @as(u32, 1234),
        @as(f64, 12.34),
        true,
        "hi",
    } ++ .{false} ** 2;
    try expect(values[0] == 1234);
    try expect(values[4] == false);
    inline for (values, 0..) |v, i| {
        if (i != 2) continue;
        try expect(v);
    }
    try expect(values.len == 6);
    try expect(values.@"3"[0] == 'h');
}
