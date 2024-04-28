// whileループは、ある条件が真でなくなるまで式を繰り返し実行するために使われる。
// whileループを早期に終了するにはbreakを使う。
// 途中でループの最初に戻るにはcontinueを使う。
const expect = @import("std").testing.expect;

test "while continue" {
    var i: usize = 0;
    while (true) {
        i += 1;
        if (i < 10)
            continue;
        break;
    }
    try expect(i == 10);
}
    