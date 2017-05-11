import XCTest
import MKTData

@testable import MKTPlayer

class BoardGameFindTests: XCTestCase {

    func testShouldFindNoValueWithFalseFilter() {
        let elements = BoardGame(board:[[0,0,0],[0,0,0]])!.findElements{ i in false }
        XCTAssertEqual(elements.count, 0)
    }

    func testShouldFindAllValuesWithTrueFilter() {
        let elements = BoardGame(board:[[0,0,0]])!.findElements{ i in true }
        XCTAssertEqual(elements.count, 3)
    }

    func testShouldFindOneValueWithGivenFilter() {
        let elements = BoardGame(board:[[1,0,0]])!.findElements{ i in i == 1 }
        XCTAssertEqual(elements.count, 1)
    }

    func testShouldFindTwoValueWithGivenFilter() {
        let elements = BoardGame(board:[[1,0,0]])!.findElements{ i in i == 0 }
        XCTAssertEqual(elements.count, 2)
    }

    static var allTests : [(String, (BoardGameFindTests) -> () throws -> Void)] {
        return [
            ("testShouldFindNoValueWithFalseFilter", testShouldFindNoValueWithFalseFilter),
            ("testShouldFindAllValuesWithTrueFilter", testShouldFindAllValuesWithTrueFilter),
            ("testShouldFindOneValueWithGivenFilter", testShouldFindOneValueWithGivenFilter),
            ("testShouldFindTwoValueWithGivenFilter", testShouldFindTwoValueWithGivenFilter)
        ]
    }

}
