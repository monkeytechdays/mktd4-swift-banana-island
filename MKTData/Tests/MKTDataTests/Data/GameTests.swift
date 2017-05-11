import XCTest
import SwiftyJSON

@testable import MKTData

class GameTests: XCTestCase {

    // builder

    func testShouldHaveAGame() {
        let game = BoardGame(board:[[]]).map { b in Game(boardGame:b, players:[]) }
        XCTAssertNotNil(game)
    }

    func testShouldRetrieveBoardFromAGame() {
        let game = BoardGame(board:[[]]).map { b in Game(boardGame:b, players:[]) }!
        XCTAssertNotNil(game.getBoardGame())
    }

    func testShouldRetrievePlayersFromAGame() {
        let game = BoardGame(board:[[]]).map { b in Game(boardGame:b, players:[]) }!
        XCTAssertEqual(game.getPlayers().count, 0)
    }

    // serialize

    func testShouldSerializeAGame() {
        let game = BoardGame(board:[[]]).map { b in Game(boardGame:b, players:[]) }!.serialize()
        XCTAssertNotNil(game)
    }

    func testShouldSerializeDeserializeAGame() {
        let game = Game(json: JSON(BoardGame(board:[[]]).map { b in Game(boardGame:b, players:[Player(id:1,name:"Test",score:42)]) }!.serialize()))
        XCTAssertNotNil(game)
    }

    func testShouldDeserializeAGame() {
        XCTAssertNotNil(Game(json: ["map": [[0],[0]],"gamers": []]))
    }

    func testShouldNotDeserializeAGame() {
        XCTAssertNil(Game(json: ["map": [[0],["0"]],"gamers": []]))
    }

    static var allTests : [(String, (GameTests) -> () throws -> Void)] {
        return [
            ("testShouldHaveAGame", testShouldHaveAGame),
            ("testShouldRetrieveBoardFromAGame", testShouldRetrieveBoardFromAGame),
            ("testShouldRetrievePlayersFromAGame", testShouldRetrievePlayersFromAGame),
            ("testShouldSerializeAGame", testShouldSerializeAGame),
            ("testShouldSerializeDeserializeAGame", testShouldSerializeDeserializeAGame),
            ("testShouldDeserializeAGame", testShouldDeserializeAGame),
            ("testShouldNotDeserializeAGame", testShouldNotDeserializeAGame)
        ]
    }
}
