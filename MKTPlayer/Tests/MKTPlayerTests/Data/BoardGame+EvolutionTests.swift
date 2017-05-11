import XCTest
import MKTData

@testable import MKTPlayer

class BoardGameEvolutionTests: XCTestCase {

    func testShouldSetTheValue() {
        let boardGame = BoardGame(board:[[0,0,0],[0,0,0]])!.setElementAt(x:1,y:1, 1)
        XCTAssertEqual(boardGame.getElementAt(x:1,y:1)!, 1)
    }

    func testShouldSetTheValueTwice() {
        let boardGame = BoardGame(board:[[0,0,0],[0,0,0]])!.setElementAt(x:1,y:1, 1).setElementAt(x:1,y:1, 2)
        XCTAssertEqual(boardGame.getElementAt(x:1,y:1)!, 2)
    }

    func testShouldSetDoesNotModifyTheInitialboard() {
        let boardGame = BoardGame(board:[[0,0,0],[0,0,0]])!
        let _ = boardGame.setElementAt(x:1,y:1, 1)
        XCTAssertEqual(boardGame.getElementAt(x:1,y:1)!, 0)
    }

    static var allTests : [(String, (BoardGameEvolutionTests) -> () throws -> Void)] {
        return [
            ("testShouldSetTheValue", testShouldSetTheValue),
            ("testShouldSetTheValueTwice", testShouldSetTheValueTwice),
            ("testShouldSetDoesNotModifyTheInitialboard", testShouldSetDoesNotModifyTheInitialboard)
        ]
    }

}
