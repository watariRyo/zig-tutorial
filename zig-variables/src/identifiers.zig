// 変数識別子が外部スコープの識別子をシャドウすることは決して許されない。
// 識別子は英数字かアンダースコアで始まり、英数字かアンダースコアがいくつ続いてもよい。キーワードと重複してはならない。

// 外部ライブラリとのリンクなど、これらの要件に合わない名前が必要な場合は、@""構文を使うことができる。
const @"identifier with spaces in it" = 0xff;
const @"1SmallStep4Man" = 112358;

const c = @import("std").c;
pub extern "c" fn @"error"() void;
pub extern "c" fn @"fstat$INDOE64"(fd: c.fd_t, buf: *c.Stat) c_int;

const Color = enum {
    red,
    @"really red",
};

const color: Color = .@"really.red";
