const expect = @import("std").testing.expect;
const mem = @import("std").mem;

// 宣言
const Type = enum {
    ok,
    not_ok,
};

// enum フィールド変数宣言
const c = Type.ok;

// 列挙型の序数にアクセスしたい場合はタグタイプの宣言
const Value = enum(u2) {
    zero,
    one,
    two,
};

// u2とvalue間のキャスト
test "enum ordinal value" {
    try expect(@intFromEnum(Value.zero) == 0);
    try expect(@intFromEnum(Value.one) == 1);
    try expect(@intFromEnum(Value.two) == 2);
}

// 序数のオーバーライド
const Value2 = enum(u32) {
    hundred = 100,
    thousand = 1000,
    million = 1000000,
};
test "set enum ordinal value" {
    try expect(@intFromEnum(Value2.hundred) == 100);
    try expect(@intFromEnum(Value2.thousand) == 1000);
    try expect(@intFromEnum(Value2.million) == 1000000);
}

// 一部だけオーバーライドも可能。後続はそこからのカウント
const Value3 = enum(u4) {
    a,
    b = 8,
    c,
    d = 4,
    e,
};
test "enum implicit ordinal values and overridden values" {
    try expect(@intFromEnum(Value3.a) == 0);
    try expect(@intFromEnum(Value3.b) == 8);
    try expect(@intFromEnum(Value3.c) == 9);
    try expect(@intFromEnum(Value3.d) == 4);
    try expect(@intFromEnum(Value3.e) == 5);
}

// 構造体やユニオンと同じように、列挙型もメソッドを持つことができる。
// 列挙型のメソッドは特別なものではなく、名前空間を持つだけ。
// ドット構文で呼び出すことができる関数にすぎない
const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,

    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};
test "enum method" {
    const p = Suit.spades;
    try expect(!p.isClubs());
}

// swich文での使用
const Foo = enum {
    string,
    number,
    none,
};
test "enum switch" {
    const p = Foo.number;
    const what_is_it = switch (p) {
        Foo.string => "this is a string",
        Foo.number => "this is a number",
        Foo.none => "this is a none",
    };
    try expect(mem.eql(u8, what_is_it, "this is a number"));
}

// typeInfoを使うと、列挙型の整数タグ型にアクセスできる。
const Small = enum {
    one,
    two,
    three,
    four,
};
test "std.meta.Tag" {
    try expect(@typeInfo(Small).Enum.tag_type == u2);
}

// @typeInfoはフィールド数とフィールド名を示す：
test "@typeInfo" {
    try expect(@typeInfo(Small).Enum.fields.len == 4);
    try expect(mem.eql(u8, @typeInfo(Small).Enum.fields[1].name, "two"));
}

// tagNameは列挙型の値を[:0]const u8で表します：
test "@tagName" {
    try expect(mem.eql(u8, @tagName(Small.three), "three"));
}
