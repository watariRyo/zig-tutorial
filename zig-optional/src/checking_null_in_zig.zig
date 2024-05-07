const Foo = struct {};
fn doSomethingWithFoo(foo: *Foo) void {
    _ = foo;
}

fn doAThing(optional_foo: ?*Foo) void {
    // do some stuff

    // ifブロックの中ではfooはもはやオプションのポインターではなく、nullにはなり得ないポインター
    // この利点のひとつは、ポインターを引数にとる関数に「nonnull」属性（GCCでは__attribute__((nonnull))）をアノテーションできること
    if (optional_foo) |foo| {
        doSomethingWithFoo(foo);
    }

    // do some stuff
}

