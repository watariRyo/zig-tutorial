// ブロックは変数宣言の範囲を限定するために使われる：
test "access variable after block scope" {
    {
        var x: i32 = 1;
        _ = &x;
    }
    // x += 1;
}
