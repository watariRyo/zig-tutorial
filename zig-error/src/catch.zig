const parseU64 = @import("error_union_parsing_u64.zig").parseU64;

fn doAThing(str: []u8) void {
    const number = parseU64(str, 10) catch 13;
    _ = number; // ...
}
// このコードでは、numberは正常にパースされた文字列、またはデフォルト値の13に等しくなる。
// 二項キャッチ演算子の右辺の型は、ラップされていないエラー・ユニオンの型と一致するか、noreturn型でなければならない。

// 何らかのロジックを実行した後にcatchでデフォルト値を提供したい場合は、catchと名前付きブロックを組み合わせることができる：
fn doAThing2(str: []u8) void {
    const number = parseU64(str, 10) catch blk: {
        // do things
        break :blk 13;
    };
    _ = number; // number is now initialized
}
