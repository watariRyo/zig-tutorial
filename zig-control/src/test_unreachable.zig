// DebugおよびReleaseSafeモードでは、unreachableは到達不能コードに達したメッセージとともにパニックを呼び出します。
// ReleaseFastモードとReleaseSmallモードでは、オプティマイザは到達不可能なコードがヒットすることはないという仮定を使用して最適化を実行する。

// unreachable は、制御フローが特定の場所に到達しないことを保証するために使用される
// アサートするために使用される
test "basic math" {
    const x = 1;
    const y = 2;
    if (x + y != 3) {
        unreachable;
    }
}

// std.debug.assertの実装方法である。
fn assert(ok: bool) void {
    if (!ok) unreachable; // assertion failure
}

// 到達不能にぶつかったので、このテストは失敗する。
test "this will fail" {
    assert(false);
}

// test "type of unreachable" {
//     comptime {
//         //  到達不能のタイプはnoreturnである。

//         // しかし、このアサーションはコンパイルに失敗します。
//         // 到達不能式はコンパイルエラーになるからです。
//         assert(@TypeOf(unreachable) == noreturn);
//     }
// }
