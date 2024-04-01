// 宣言
// Zigは、フィールドの順序と構造体のサイズについては保証しない。
// しかし、フィールドはABIアラインされていることが保証される。
const Point = struct {
    x: f32,
    y: f32,
};

// byteがどのように配置されるか
// メモリ内レイアウトが保証される
const Point2 = packed struct {
    x: f32,
    y: f32,
};

// インスタンス宣言
const p = Point{
    .x = 0.12,
    .y = 0.34,
};

// yを定義できない場合
var p2 = Point{
    .x = 0.12,
    .y = undefined,
};

// 構造体はメソッドを持つことができる
// 構造体のメソッドは特別なものではなく、名前空間を持つだけである。
// ドット構文で呼び出すことができる関数
const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32,

    pub fn init(x: f32, y: f32, z: f32) Vec3 {
        return Vec3{
            .x = x,
            .y = y,
            .z = z,
        };
    }

    pub fn dot(self: Vec3, other: Vec3) f32 {
        return self.x * other.x + self.y * other.y + self.z * other.z;
    }
};

const expect = @import("std").testing.expect;
test "dot product" {
    const v1 = Vec3.init(1.0, 0.0, 0.0);
    const v2 = Vec3.init(0.0, 1.0, 0.0);
    try expect(v1.dot(v2) == 0.0);

    // 構造体メソッドは、ドット構文で呼び出すことができる以外に特別なことはない。
    // 構造体の内部で他の宣言と同じように参照可能
    try expect(Vec3.dot(v1, v2) == 0.0);
}

// 構造体は宣言を持つことができる。
// 構造体は0個のフィールドを持つことができる。
const Empty = struct {
    pub const PI = 3.14;
};
test "struct namespaced variable" {
    try expect(Empty.PI == 3.14);
    try expect(@sizeOf(Empty) == 0);

    // 空の構造体をインスタンス化することはできる。
    const does_nothing = Empty{};

    _ = does_nothing;
}

// 構造体フィールドの順序は、最適なパフォーマンスを実現するためにコンパイラが決定する。
// しかし、フィールド・ポインタがあれば、構造体のベース・ポインタを計算することが可能：
fn setYBasedOnX(x: *f32, y: f32) void {
    const point = @fieldParentPtr(Point, "x", x);
    point.y = y;
}
test "field parent pointer" {
    var point = Point{
        .x = 0.1234,
        .y = 0.5678,
    };
    setYBasedOnX(&point.x, 0.9);
    try expect(point.y == 0.9);
}

// 関数から構造体を返すことができる。ジェネリックス
fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            prev: ?*Node,
            next: ?*Node,
            data: T,
        };
        first: ?*Node,
        last: ?*Node,
        len: usize,
    };
}

test "linked list" {
    // コンパイル時に呼び出される関数はメモ化される
    try expect(LinkedList(i32) == LinkedList(i32));

    var list = LinkedList(i32){
        .first = null,
        .last = null,
        .len = 0,
    };
    try expect(list.len == 0);

    // 型はファーストクラスの値なので、変数に代入することで型をインスタンス化できる。
    const ListOfInts = LinkedList(i32);
    try expect(ListOfInts == LinkedList(i32));

    var node = ListOfInts.Node{
        .prev = null,
        .next = null,
        .data = 1234,
    };
    var list2 = LinkedList(i32){
        .first = &node,
        .last = &node,
        .len = 1,
    };

    // 構造体へのポインタを使用する場合、ポインタを明示的に再参照することなく、
    // フィールドに直接アクセスすることができる、
    // ポインタを明示的に再参照することなく、フィールドに直接アクセス可能。
    try expect(list2.first.?.data == 1234);
}
