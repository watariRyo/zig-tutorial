const expect = @import("std").testing.expect;

test "for basics" {
    const items = [_]i32{ 4, 5, 3, 4, 0 };
    var sum: i32 = 0;

    // sliceと配列を繰り返し処理する
    for (items) |value| {
        // Break and continue
        if (value == 0) {
            continue;
        }
        sum += value;
    }
    try expect(sum == 16);

    // 範囲指定
    for (items[0..1]) |value| {
        sum += value;
    }
    try expect(sum == 20);

    // 反復のインデックスにアクセスするには、2つ目の条件も指定する。
    var sum2: i32 = 0;
    for (items, 0..) |_, i| {
        try expect(@TypeOf(i) == usize);
        sum2 += @as(i32, @intCast(i));
    }
    try expect(sum2 == 10);

    // 連続する整数を反復処理するには、範囲構文を使う。
    // 束縛されていない範囲は常にコンパイルエラーとなる。
    var sum3: usize = 0;
    for (0..5) |i| {
        sum3 += i;
    }
    try expect(sum3 == 10);
}

test "multi object for" {
    const items = [_]usize{ 1, 2, 3 };
    const items2 = [_]usize{ 4, 5, 6 };
    var count: usize = 0;

    // 複数のオブジェクトを反復処理する。
    // ループの開始時にすべての長さが等しくなければならない。
    // 不正な動作が発生する
    for (items, items2) |i, j| {
        count += i + j;
    }

    try expect(count == 21);
}

test "for reference" {
    var items = [_]i32{ 3, 4, 2 };

    // キャプチャ値をポインタに指定することで、スライスを参照で反復処理する。
    for (&items) |*value| {
        value.* += 1;
    }

    try expect(items[0] == 4);
    try expect(items[1] == 5);
    try expect(items[2] == 3);
}

test "for else" {
    const items = [_]?i32{ 3, 4, null, 5 };

    // else。ループ終了時に実行される
    var sum: i32 = 0;
    const result = for (items) |value| {
        if (value != null) {
            sum += value.?;
        }
    } else blk: {
        try expect(sum == 12);
        break :blk sum;
    };
    try expect(result == 12);
}
