// noreturnは以下
// break
// continue
// return
// unreachable
// while (true) {}

// if節やスイッチ・プロングなど、型を一緒に解決する場合、noreturn型は他のすべての型と互換性がある。
fn foo(condition: bool, b: u32) void {
    const a = if (condition) b else return;
    _ = a;
    @panic("do something with a");
}
test "noreturn" {
    foo(false, 1);
}
