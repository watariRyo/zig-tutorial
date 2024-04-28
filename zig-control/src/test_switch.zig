const std = @import("std");
const builtin = @import("builtin");
const expect = std.testing.expect;

test "switch simple" {
    const a: u64 = 101;
    const zz: u64 = 103;

    // 他のメジャーな静的型付け言語と一緒
    // 分岐の型は同一でないといけない。フォールスルーできない
    const b = switch (a) {
        1, 2, 3 => 0,
        // 範囲指定
        5...100 => 1,
        //
        101 => blk: {
            const c: u64 = 5;
            break :blk c * 2 + 1;
        },

        // コンパイル時に式が既知である場合、それを使用可能
        zz => zz,
        blk: {
            const d: u32 = 5;
            const e: u32 = 100;
            break :blk d + e;
        } => 107,

        // 他言語のdefault
        // 値の全範囲を分岐しない場合、elseは必須
        else => 9,
    };

    try expect(b == 11);
}

// 関数の外部で使用可能＝式である
const os_msg = switch (builtin.target.os.tag) {
    .linux => "we found a linux user",
    else => "not a linux user",
};

// 関数内部では、switch文は暗黙的にコンパイル時に評価される。
// ターゲット式がコンパイル時に既知であれば
// 評価される。
test "switch inside function" {
    switch (builtin.target.os.tag) {
        .fuchsia => {
            // fuchsia 以外の OS では、ブロックは解析されない、
            // そのため、このコンパイルエラーは発生しない。
            // フクシアではこのコンパイル・エラーが発生する。
            @compileError("fuchsia not supported");
        },
        else => {},
    }
}
