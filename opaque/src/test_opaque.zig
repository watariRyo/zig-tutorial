// opaque {}は、サイズとアラインメントが未知の（しかしゼロではない）新しい型を宣言する。
// 構造体、共用体、列挙体と同じ宣言を含むことができる
// これは通常、構造体の詳細を公開しないCコードとやりとりする際の型安全のために使用される

const Derp = opaque {};
const Wat = opaque {};

extern fn bar(d: *Derp) void;
fn foo(w: *Wat) callconv(.C) void {
    bar(w);
}

test "call foo" {
    foo(undefined);
}
