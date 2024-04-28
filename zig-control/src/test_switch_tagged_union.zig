const expect = @import("std").testing.expect;

test "switch on tagged union" {
    const Point = struct {
        x: u8,
        y: u8,
    };
    const Item = union(enum) {
        a: u32,
        c: Point,
        d,
        e: u32,
    };

    var a = Item{ .c = Point{ .x = 1, .y = 2 } };

    // 列挙型のswitch
    const b = switch (a) {
        // キャプチャー・グループはマッチ時に許可され、マッチした列挙型 // 値を返す。
        // 値を返す。両方の場合のペイロード型が同じであれば、 // 同じスイッチプロングに入れることができる。
        Item.a, Item.e => |item| item,

        // マッチした値への参照は `*` 構文で取得できる。
        Item.c => |*item| blk: {
            item.*.x += 1;
            break :blk 6;
        },

        // タイプのケースを網羅的に処理した場合elseは不要
        Item.d => 8,
    };

    try expect(b == 6);
    try expect(a.c.x == 2);
}
