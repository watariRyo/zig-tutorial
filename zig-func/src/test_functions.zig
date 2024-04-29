const std = @import("std");
const builtin = @import("builtin");
const native_arch = builtin.cpu.arch;
const expect = std.testing.expect;

// 宣言
fn add(a: i8, b: i8) i8 {
    if (a == 0) {
        return b;
    }

    return a + b;
}

// exportは生成されたオブジェクト・ファイルで関数を外部から見えるようにする
export fn sub(a: i8, b: i8) i8 {
    return a - b;
}

// extern指定子は、リンク時に解決される関数を宣言するために使われる。
// 動的にリンクする場合は実行時に解決される
// extern キーワードの後の引用符で囲まれた識別子は関数を持つライブラリを指定。(例: "c" -> libc.so)。
// callconv指定子は、関数の呼び出し規則を変更
const WINAPI: std.builtin.CallingConvention = if (native_arch == .x86) .Stdcall else .C;
extern "kernel32" fn ExitProcess(exit_code: u32) callconv(WINAPI) noreturn;
extern "c" fn atan2(a: f64, b: f64) f64;

// setCold組み込み関数は、関数がめったに呼び出されないことをオプティマイザに伝える。
fn abort() noreturn {
    @setCold(true);
    while (true) {}
}

// ネイキッド呼び出し規約により、関数はプロローグやエピローグを持たない。
// これはアセンブリと統合する際に便利
fn _start() callconv(.Naked) noreturn {
    abort();
}

// インライン呼び出し規約では、関数はすべての呼び出し先でインライン化される。
// 関数がインライン化できない場合、コンパイル時エラーとなる。

// 一般に、関数をインライン化するタイミングはコンパイラに任せた方がよい：

// デバッグのために、呼び出しスタックにあるスタック・フレームの数を変更する場合。 実世界の性能測定では、これが必要です。
// インラインは、コンパイラができることを制限していることに注意する。これは、バイナリ・サイズやコンパイル速度、さらには実行時性能にまで悪影響を及ぼす可能性がある。
inline fn shiftLeftOne(a: u32) u32 {
    return a << 1;
}

// pub 指定子は、インポート時に関数を表示できるようにする。
// 別のファイルが@importを使用し、sub2を呼び出すことができる。
pub fn sub2(a: i8, b: i8) i8 {
    return a - b;
}

// 関数ポインタの先頭には `*const ` が付く。
// 関数本体と関数ポインタには違いがある。ファンクション・ボディは計算時のみの型であるのに対し、ファンクション・ポインターは実行時に知ることができる。
const Call2Op = *const fn (a: i8, b: i8) i8;
fn doOp(fnCall: Call2Op, op1: i8, op2: i8) i8 {
    return fnCall(op1, op2);
}

test "function" {
    try expect(doOp(add, 5, 6) == 11);
    try expect(doOp(sub2, 5, 6) == -1);
}
