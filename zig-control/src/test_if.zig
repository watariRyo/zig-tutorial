// if式には3つの用途があり、3つの型に対応している
// * bool
// * ?T
// * anyerror!T

const expect = @import("std").testing.expect;

test "if expression" {
    // 三項式の代わりに式を使用する場合。
    const a: u32 = 5;
    const b: u32 = 4;
    const result = if (a != b) 47 else 3089;
    try expect(result == 47);
}

test "if boolean" {
    // If式はブール条件をテストする。
    const a: u32 = 5;
    const b: u32 = 4;
    if (a != b) {
        try expect(true);
    } else if (a == 9) {
        unreachable;
    } else {
        unreachable;
    }
}

test "if error union" {
    // if式はエラーをテストする。
    // else の |err| キャプチャーに注意。

    const a: anyerror!u32 = 0;
    if (a) |value| {
        try expect(value == 0);
    } else |err| {
        _ = err;
        unreachable;
    }

    const b: anyerror!u32 = error.BadValue;
    if (b) |value| {
        _ = value;
        unreachable;
    } else |err| {
        try expect(err == error.BadValue);
    }

    // elseと|err|のキャプチャは厳密に必要である。
    if (a) |value| {
        try expect(value == 0);
    } else |_| {}

    // エラー値だけをチェックするには、空のブロック式を使用する。
    if (b) |_| {} else |err| {
        try expect(err == error.BadValue);
    }

    // ポインタ・キャプチャを使用して参照で値にアクセスする。
    var c: anyerror!u32 = 3;
    if (c) |*value| {
        value.* = 9;
    } else |_| {
        unreachable;
    }

    if (c) |value| {
        try expect(value == 9);
    } else |_| {
        unreachable;
    }
}
