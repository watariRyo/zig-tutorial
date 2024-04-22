// 構造体はすべて匿名なので、Zigはいくつかのルールに基づいて型名を推測する。

// 構造体が変数の初期化式に含まれている場合は、その変数にちなんだ名前が付けられる
// 構造体が戻り値の式の中にある場合は、戻り元の関数にちなんだ名前になり、パラメータの値は直列化される。
// それ以外の場合、構造体には（filename.funcname.__struct_ID）のような名前が付けられる
// 構造体が別の構造体の内部で宣言されている場合は、親構造体の名前と前の規則で推測される名前の両方をドットで区切って使用
const std = @import("std");

pub fn main() void {
    const Foo = struct {};
    std.debug.print("variable: [s]\n", .{@typeName(Foo)});
    std.debug.print("anonymas [s]\n", .{@typeName(struct {})});
    std.debug.print("function: [s]\n", .{@typeName(List(i32))});
}

fn List(comptime T: type) type {
    return struct {
        x: T,
    };
}
