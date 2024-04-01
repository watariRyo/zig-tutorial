// デフォルトフィールド値
// 各構造体フィールドには、デフォルトのフィールド値を示す式が含まれる場合あり。
// このような式はcomptimeで実行され、構造体リテラル式でフィールドを省略可能。
const Foo = struct {
    a: i32 = 1234,
    b: i32,
};

test "default struct initialization fields" {
    const x = Foo{
        .b = 5,
    };
    if (x.a + x.b != 1239) {
        @compileError("it's even comptime-known!");
    }
}
