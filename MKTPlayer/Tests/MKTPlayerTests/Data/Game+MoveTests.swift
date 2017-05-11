import XCTest
import MKTData

@testable import MKTPlayer

class GameMoveTests: XCTestCase {

    func testShouldMoveNorth() {
        let game = BoardGame(board:[[0],[2]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.North))

        XCTAssertEqual(game.getElementAt(x:0, y:1)!, 0)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 2)
    }

    func testShouldNotMoveNorth() {
        let game = BoardGame(board:[[0],[2]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.North))
                    .move(Move(id:2, direction:.North))

        XCTAssertEqual(game.getElementAt(x:0, y:1)!, 0)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 2)
    }

    func testShouldMoveSouth() {
        let game = BoardGame(board:[[2],[0]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.South))

        XCTAssertEqual(game.getElementAt(x:0, y:1)!, 2)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 0)
    }

    func testShouldNotMoveSouth() {
        let game = BoardGame(board:[[2],[0]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.South))
                    .move(Move(id:2, direction:.South))

        XCTAssertEqual(game.getElementAt(x:0, y:1)!, 2)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 0)
    }

    func testShouldMoveEst() {
        let game = BoardGame(board:[[2,0]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.East))

        XCTAssertEqual(game.getElementAt(x:1, y:0)!, 2)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 0)
    }

    func testShouldNotMoveEst() {
        let game = BoardGame(board:[[2,0]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.East))
                    .move(Move(id:2, direction:.East))

        XCTAssertEqual(game.getElementAt(x:1, y:0)!, 2)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 0)
    }

    func testShouldMoveWest() {
        let game = BoardGame(board:[[0,2]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.West))

        XCTAssertEqual(game.getElementAt(x:1, y:0)!, 0)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 2)
    }

    func testShouldNotMoveWest() {
        let game = BoardGame(board:[[0,2]]).map { b in Game(boardGame:b, players:[]) }!
                    .move(Move(id:2, direction:.West))
                    .move(Move(id:2, direction:.West))

        XCTAssertEqual(game.getElementAt(x:1, y:0)!, 0)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 2)
    }

    func testShouldNotMove() {
        let game = BoardGame(board:[[0,2]]).map { b in Game(boardGame:b, players:[]) }!.move(Move(id:2, direction:.None))
        XCTAssertEqual(game.getElementAt(x:1, y:0)!, 2)
        XCTAssertEqual(game.getElementAt(x:0, y:0)!, 0)
    }

    static var allTests : [(String, (GameMoveTests) -> () throws -> Void)] {
        return [
            ("testShouldMoveNorth", testShouldMoveNorth),
            ("testShouldNotMoveNorth", testShouldNotMoveNorth),
            ("testShouldMoveSouth", testShouldMoveSouth),
            ("testShouldNotMoveSouth", testShouldNotMoveSouth),
            ("testShouldMoveEst", testShouldMoveEst),
            ("testShouldNotMoveEst", testShouldNotMoveEst),
            ("testShouldMoveWest", testShouldMoveWest),
            ("testShouldNotMoveWest", testShouldNotMoveWest),
            ("testShouldNotMove", testShouldNotMove),
        ]
    }

}
