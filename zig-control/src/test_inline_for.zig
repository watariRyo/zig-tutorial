// Forループはインライン化できる。
// これによってループがアンロールされ、コンパイル時にしか動作しないようなことができるようになる。
// インライン化されたforループのキャプチャ値とイテレータ値は、コンパイル時に既知である。
const expect = @import("std").testing.expect;

// インライン・ループを使用することをお勧めするのは、以下のいずれかの理由に限られる：
// セマンティクスを機能させるために、ループをカンプタイムで実行する必要がある。
// この方法で強制的にループをアンロールした方が測定不能なほど高速であることを証明するベンチマークがある。
test "inline for loop" {
    const nums = [_]i32{ 2, 4, 6 };
    var sum: usize = 0;
    inline for (nums) |i| {
        const T = switch (i) {
            2 => f32,
            4 => i8,
            6 => bool,
            else => unreachable,
        };
        sum += typeNameLength(T);
    }
    try expect(sum == 9);
}

fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}
