// ベアユニオンは、フィールドのリストとして、値がとりうる型の集合を定義する。
// 一度にアクティブにできるフィールドは1つだけ。ベアユニオンのメモリ内表現は保証されない。
// ベアユニオンを使ってメモリを再解釈することはできない。その場合は@ptrCastを使用するか、メモリ内レイアウトが保証されているexternユニオンやpackedユニオンを使用。
// 非アクティブ・フィールドへのアクセスは、安全が確認された未定義動作である：

const Payload = union {
    int: i64,
    float: f64,
    boolean: bool,
};
// intをアクティブにしたのにfloatにアクセスするのでエラー
test "simple union" {
    var payload = Payload{ .int = 1234 };
    payload.float = 12.34;
}
