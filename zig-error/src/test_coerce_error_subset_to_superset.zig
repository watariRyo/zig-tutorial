// エラー・セットは列挙型のようなもの。同じエラー名を複数回宣言することは可能で、宣言した場合は同じ整数値が割り当てられる。
// エラー・セットの型のデフォルトはu16だが、--error-limit [num]コマンド・ライン・パラメーターでエラー値の最大数を指定すると、すべてのエラー値を表すのに必要な最小ビット数の整数型が使われる。
// エラーをサブセットからスーパーセットに強制することができる：

const std = @import("std");

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{
    OutOfMemory,
};

test "coerce subset to superset" {
    const err = foo(AllocationError.OutOfMemory);
    try std.testing.expect(err == FileOpenError.OutOfMemory);
}

fn foo(err: AllocationError) FileOpenError {
    return err;
}

// しかし、スーパーセットからサブセットにエラーを強要することはできない：
test "coerce superset to subset" {
    foo2(FileOpenError.OutOfMemory) catch {};
}

fn foo2(err: FileOpenError) AllocationError {
    return err;
}

// anyerror - Global Error Set
// anyerrorはグローバル・エラー・セットを指す。これはコンパイル・ユニット全体のすべてのエラーを含むエラー・セットである。
// これは他のすべてのエラー・セットの上位集合

// 任意のエラー・セットをグローバル・エラー・セットに強制することができ、グローバル・エラー・セットのエラーを非グローバル・エラー・セットに明示的にキャストすることができる。
// この場合、エラー値が実際に出力先のエラーセットに含まれていることを確認するために、 言語レベルのアサートが挿入されます。

// グローバル・エラー・セットは、コンパイラがコンパイル時にどのようなエラーが起こりうるかを知ることができないため、
// 一般的には避けるべきである。コンパイル時にエラー・セットを知っていた方が、生成されるドキュメントや、スイッチで起こりうるエラー値を忘れるといった有用なエラー・メッセージの作成に役立つ
