// ポインターは、コードが未定義のメモリーレイアウトに依存しない限り、コンパイル時にも機能する：

const expect = @import("std").testing.expect;

test "comptime pointers" {
    comptime {
        var x: i32 = 1;
        const ptr = &x;
        ptr.* += 1;
        x += 1;
        try expect(ptr.* == 3);
    }
}
