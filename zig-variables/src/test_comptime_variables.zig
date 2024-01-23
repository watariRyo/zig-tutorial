const std = @import("std");
const expect = std.testing.expect;

// ローカル変数は、Functions、comptimeブロック、@cImportブロックの中で使われる。

// ローカル変数がconstの場合、初期化後はその変数の値が変化しないことを意味する。const変数の初期化値がcomptime-knownであれば、その変数もcomptime-known

// ローカル変数は comptime キーワードで修飾することができる。
// これにより、その変数の値はcomptime-knownとなり、その変数のロードとストアはすべて、
// 実行時ではなくプログラムの意味解析時に行われるようになる。comptime式で宣言された変数はすべて暗黙的にcomptime変数となる。

test "comptime vars" {
    var x: i32 = 1;
    comptime var y: i32 = 1;

    x += 1;
    y += 1;

    try expect(x == 2);
    try expect(y == 2);

    if (y != 2) {
        @compileError("wrong y value");
    }
}
