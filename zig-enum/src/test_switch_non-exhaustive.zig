// 末尾に_フィールドを追加することで、非網羅的な列挙型を作成することができる。
// 列挙型はタグタイプを指定しなければならず、すべての列挙値を消費することはできない。

// 非網羅型列挙型の @enumFromInt は、@intCast の安全なセマンティクスを整数タグ型に適用しますが、
// それ以上の場合は常に明確に定義された列挙型値になります。

// 非網羅的列挙型のスイッチには、elseプロングの代わりに_プロングを含めることができます。
// プロングを使用すると、既知のタグ名がすべてスイッチで処理されない場合、コンパイラはエラーになります。

const std = @import("std");
const expect = std.testing.expect;

const Number = enum(u8) {
    one,
    two,
    three,
    _,
};

test "switch on non-exhaustive enum" {
    const number = Number.one;
    const result = switch (number) {
        .one => true,
        .two, .three => false,
        _ => false,
    };
    try expect(result);
    const is_one = switch (number) {
        .one => true,
        else => false,
    };
    try expect(is_one);
}
