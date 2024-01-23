const std = @import("std");
const assert = std.debug.assert;

// 変数をスレッドローカル変数に指定するにはthreadlocalキーワードを使う
threadlocal var x: i32 = 1234;

test "thread local storage" {
    // スレッドが変数の個別のインスタンスで動作するようにする
    const thread1 = try std.Thread.spawn(.{}, testTls, .{});
    const thread2 = try std.Thread.spawn(.{}, testTls, .{});
    testTls();
    thread1.join();
    thread2.join();
}

fn testTls() void {
    assert(x == 1234);
    x += 1;
    assert(x == 1235);
}

// シングル・スレッド・ビルドの場合、すべてのスレッド・ローカル変数は通常のコンテナ・レベル変数となる
// スレッドローカル変数は const にはできない
