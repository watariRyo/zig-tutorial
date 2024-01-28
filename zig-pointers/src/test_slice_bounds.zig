const expect = @import("std").testing.expect;

test "pointer slicing" {
    // 配列やポインタをスライスにするには、スライス構文を使う
    var array = [_]u8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    var start: usize = 2;
    const slice = array[start..4];
    try expect(slice.len == 2);

    try expect(array[3] == 4);
    slice[1] += 1;
    try expect(array[3] == 5);
}
