// エラー処理のもう一つの要素はdefer文である。無条件のdeferに加えて、Zigにはerrdeferがあり、
// これはブロックから関数がエラーで戻ってきた場合にのみ、ブロックの出口パスでdeferred式を評価する。

// fn createFoo(param: i32) !Foo {
//     const foo = try tryToAllocateFoo();
//     // 関数が失敗した場合は解放する必要がある。
//     // しかし、関数が成功したらそれを返したい。
//     errdefer deallocateFoo(foo);

//     const tmp_buf = allocateTmpBuffer() orelse return error.OutOfMemory;
//     defer deallocateTmpBuffer(tmp_buf);

//     if (param > 1337) return error.InvalidParam;

//     // 関数から成功を返しているので、errdeferは実行されない。
//     // しかし、deferは実行される
//     return foo;
// }

// これの優れた点は、すべての出口パスをカバーしようとする冗長さや認知的なオーバーヘッドなしに、堅牢なエラーハンドリングが得られることだ。
// アロケーション解除コードは常にアロケーションコードの直後にある。

// よくあるerrdeferのミス
// errdefer文は、それが書かれたブロックの終わりまでしか続かないので、そのブロックの外でエラーが返された場合は実行されないことに注意すべきである
