// if式と同じように、whileループも条件としてオプショナルを受け取り、ペイロードをキャプチャすることができる。nullに遭遇するとループは終了する。
// while式に｜x｜構文がある場合、while条件はオプショナル型でなければならない
// else分岐はオプショナル反復で許可されます。この場合、else分岐は最初にnull値に遭遇したときに実行される。
const expect = @import("std").testing.expect;

test "while null capture" {
    var sum1: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| {
        sum1 += value;
    }
    try expect(sum1 == 3);

    // else blockでnullキャプチャ
    var sum2: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| {
        sum2 += value;
    } else {
        try expect(sum2 == 3);
    }

    // continue blockでnullキャプチャ
    var i: u32 = 0;
    var sum3: u32 = 0;
    numbers_left = 3;
    while (eventuallyNullSequence()) |value| : (i += 1) {
        sum3 += value;
    }
    try expect(i == 3);
}

var numbers_left: u32 = undefined;
fn eventuallyNullSequence() ?u32 {
    return if (numbers_left == 0) null else blk: {
        numbers_left -= 1;
        break :blk numbers_left;
    };
}
