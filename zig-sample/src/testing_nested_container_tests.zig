const std = @import("std");
const expect = std.testing.expect;

const imported_file = @import("testing_introduction.zig");

test {
    // 入れ子になったコンテナテストを実行するには、`refAllDecls` を呼び出す。
    // 与えられた引数にあるすべての宣言を参照する。
    // `@This()` は組み込み関数で、呼び出された最も内側のコンテナを返す。
    // この例では、最も内側のコンテナはこのファイル（暗黙的に構造体）である。
    std.testing.refAllDecls(@This());

    // または、トップレベルのテスト宣言から各コンテナを個別に参照する。
    // 構文 `_ = C;` は、識別子 `C` へのノーオペ参照である。
    _ = S;
    _ = U;
    _ = @import("testing_introduction.zig");
}

const S = struct {
    test "S demo test" {
        try expect(true);
    }

    const SE = enum {
        V,
        // コンテナ（SE）が参照されていないため、このテストは実行されません。
        test "This Test Won't Run" {
            try expect(false);
        }
    };
};

const U = union { // U は、ファイルのトップレベルのテスト宣言によって参照される。
    s: US, // したがって、"U.Us demo test "が実行される。

    const US = struct {
        test "U.US demo test" {
            // このテストは、構造体に対するトップレベルのテスト宣言です。
            // 構造体はユニオンの内部にネスト（宣言）されています。
            try expect(true);
        }
    };

    test "U demo test" {
        try expect(true);
    }
};
