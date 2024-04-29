const parseU64 = @import("error_union_parsing_u64.zig").parseU64;

// エラーが発生したらエラーを返し、そうでなければ関数のロジックを続ける
fn doAThing(str: []u8) !void {
    const number = try parseU64(str, 10);
    _ = number; // ...
}

// tryはエラー・ユニオン式を評価する。それがエラーの場合、同じエラーで現在の関数から戻ります。そうでなければ、式はラップされていない値になる

// ある式が絶対にエラーにならないことが確実に分かっている場合もあるでしょう。この場合、このようにすることができる：

// const number = parseU64("1234", 10) catch unreachable；
// ここでは、"1234 "が正常にパースされることが確実にわかっている。unreachableは、DebugモードとReleaseSafeモードではパニックを発生させ、ReleaseFastモードとReleaseSmallモードでは未定義の動作を発生させます。
// そのため、アプリケーションをデバッグしているときに、ここでびっくりするようなエラーが発生すると、アプリケーションは適切にクラッシュします。

// 状況ごとに異なるアクションを取りたい場合もあるだろう。そのために、if式とswitch式を組み合わせる

// 最後に、一部のエラーだけを処理したい場合もあるだろう。その場合は、elseケースに未処理のエラーを取り込むことができる：
// fn doAnotherThing(str: []u8) error{InvalidChar}!void {
//     if (parseU64(str, 10)) |number| {
//         doSomethingWithNumber(number);
//     } else |err| switch (err) {
//         error.Overflow => {
//             // handle overflow...
//         },
//         else => |leftover_err| return leftover_err,
//     }
// }
