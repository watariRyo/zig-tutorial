// whileループは式
// 式の結果はwhileループのelse句の結果であり、whileループの条件がfalseとテストされたときに実行される。
// breakはreturnと同様、値パラメータを受け取りる。while式の結果である。whileループからbreakするとき、else分岐は評価されない

const expect = @import("std").testing.expect;

test "while else" {
    try expect(rangeHasNumber(0, 10, 5));
    try expect(!rangeHasNumber(0, 10, 15));
}

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}
