const std = @import("std");
const native_endian = @import("builtin").target.cpu.arch.endian();
const expect = std.testing.expect;

// 通常の構造体とは異なり、パック構造体はメモリ内のレイアウトが保証されている：

// フィールドは宣言された順序のままである。
// フィールド間のパディングはない
// Zigは任意の幅の整数をサポートしており、通常は8ビット未満の整数でも1バイトのメモリを使用しますが、パック構造体ではそのビット幅を正確に使用する
// boolフィールドは正確に1ビットを使用する
// enum フィールドは、その整数タグ型のビット幅を正確に使用する
// packedユニオン・フィールドは、最大のビット幅を持つユニオン・フィールドのビット幅を正確に使用する
// 非ABI整列フィールドは、ターゲットとするエンディアンに従って、可能な限り小さなABI整列整数にパックされる

const Full = packed struct {
    number: u16,
};

const Divided = packed struct {
    half1: u8,
    quarter3: u4,
    quarter4: u4,
};

// これは、パックされた構造体が@bitCastや@ptrCastに参加してメモリを再解釈できることを意味する。これはコンパイル時にも機能する：
test "@bitCast between packed structs" {
    try doTheTest();
    try comptime doTheTest();
}

fn doTheTest() !void {
    try expect(@sizeOf(Full) == 2);
    try expect(@sizeOf(Divided) == 2);
    var full = Full{ .number = 0x1234 };
    var divided: Divided = @bitCast(full);
    try expect(divided.half1 == 0x34);
    try expect(divided.quarter3 == 0x2);
    try expect(divided.quarter4 == 0x1);

    var ordered: [2]u8 = @bitCast(full);
    switch (native_endian) {
        .Big => {
            try expect(ordered[0] == 0x12);
            try expect(ordered[1] == 0x34);
        },
        .Little => {
            try expect(ordered[0] == 0x34);
            try expect(ordered[1] == 0x12);
        },
    }
}
