import XCTest
@testable import MKTData

class BoardGameTests: XCTestCase {

    // builder

    func testShouldHaveANewBoardGame() {
        let boardGame = BoardGame(board:[[1,2,3],[3,4,5]])
        XCTAssertNotNil(boardGame)
    }

    func testShouldNotHaveANewBoardGame() {
        let boardGame = BoardGame(board:[[1,2],[3,4,5]])
        XCTAssertNil(boardGame)
    }

    // size

    func testShouldHaveABoardRowsSize() {
        let dimension = BoardGame(board:[[1,2,3],[3,4,5]])?.getDimensions()
        XCTAssertEqual(dimension?.x == 3, true)
    }

    func testShouldHaveABoardColumnsSize() {
        let dimension = BoardGame(board:[[1,2,3],[3,4,5]])?.getDimensions()
        XCTAssertEqual(dimension?.y == 2, true)
    }

    // element access

    func testShouldHaveAnElementAtAGivenPosition() {
        let boardGame = BoardGame(board:[[1,2,3],[3,4,5]])!
        XCTAssertEqual(boardGame.getElementAt(x:0,y:1)!, 3)
    }

    func testShouldNotHaveAnElementAtAWrongRow() {
        let boardGame = BoardGame(board:[[1,2,3],[3,4,5]])!
        XCTAssertNil(boardGame.getElementAt(x:0,y:2))
    }

    func testShouldNotHaveAnElementAtAWrongColumn() {
        let boardGame = BoardGame(board:[[1,2,3],[3,4,5]])!
        XCTAssertNil(boardGame.getElementAt(x:3,y:1))
    }

    // serialization

    func testShouldDeserializeBoardGame() {
        let boardGame = BoardGame(json: [[0,0,0],[0,0,0]])
        XCTAssertNotNil(boardGame)
    }

    func testShoulNotDeserializeBoardGame() {
        let boardGame = BoardGame(json: [[0,"1",0],[0,0,0]])
        XCTAssertNil(boardGame)
    }

    func testShouldSerializeBoardGame() {
        let boardGame = BoardGame(json: [[0],[0]])!.serialize()
        XCTAssertEqual(boardGame.count, 2)
    }

    static var allTests : [(String, (BoardGameTests) -> () throws -> Void)] {
        return [
            ("testShouldHaveANewBoardGame", testShouldHaveANewBoardGame),
            ("testShouldNotHaveANewBoardGame", testShouldNotHaveANewBoardGame),
            ("testShouldHaveABoardRowsSize", testShouldHaveABoardRowsSize),
            ("testShouldHaveABoardColumnsSize", testShouldHaveABoardColumnsSize),
            ("testShouldHaveAnElementAtAGivenPosition", testShouldHaveAnElementAtAGivenPosition),
            ("testShouldNotHaveAnElementAtAWrongRow", testShouldNotHaveAnElementAtAWrongRow),
            ("testShouldNotHaveAnElementAtAWrongColumn", testShouldNotHaveAnElementAtAWrongColumn),
            ("testShouldDeserializeBoardGame", testShouldDeserializeBoardGame),
            ("testShoulNotDeserializeBoardGame", testShoulNotDeserializeBoardGame),
            ("testShouldSerializeBoardGame", testShouldSerializeBoardGame),
        ]
    }
}
