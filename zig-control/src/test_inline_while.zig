// Whileループはインライン化できる。これによってループがアンロールされ、
// コンパイル時にしか動作しないようなこと、たとえば型をファーストクラスの値として使うようなことができるようになる。

const expect = @import("std").testing.expect;

// インライン・ループを使用することをお勧めするのは、以下のいずれかの理由に限られる：

// セマンティクスを機能させるために、ループをカンプタイムで実行する必要がある。
// この方法で強制的にループをアンロールした方が測定不能なほど高速であることを証明するベンチマークがある。
test "inline while loop" {
    comptime var i = 0;
    var sum: usize = 0;
    inline while (i < 3) : (i += 1) {
        const T = switch (i) {
            0 => f32,
            1 => i8,
            2 => bool,
            else => unreachable,
        };
        sum += typeNameLength(T);
    }
    try expect(sum == 9);
}

fn typeNameLength(comptime T: type) usize {
    return @typeName(T).len;
}
