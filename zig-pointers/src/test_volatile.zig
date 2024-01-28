// ロードとストアは副作用がないと仮定される。MMIO（Memory Mapped Input/Output）のように、ロードやストアに副作用がある場合は、volatileを使用する。
// 下のコードでは、mmio_ptrを使ったロードとストアはすべて、ソースコードと同じ順序で起こることが保証されている：

// メモリー・マップド入出力以外でvolatileを使っているコードを見かけたら、それはおそらくバグ

const expect = @import("std").testing.expect;

test "volatile" {
    const mmio_ptr: *volatile u8 = @ptrFromInt(0x12345678);
    try expect(@TypeOf(mmio_ptr) == *volatile u8);
}