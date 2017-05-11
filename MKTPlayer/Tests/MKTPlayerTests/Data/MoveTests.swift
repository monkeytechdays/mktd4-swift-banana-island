import XCTest
import SwiftyJSON

@testable import MKTPlayer

class MoveTests: XCTestCase {

    // builder

    func testShouldHaveAMoveWithRightId() {
        let move = Move(id:1, direction:.North)
        XCTAssertEqual(move.getId(), 1)
    }

    func testShouldHaveAMoveWithRightDirection() {
        let move = Move(id:1, direction:.North)
        XCTAssertEqual(move.getDirection(), .North)
    }

    // serialization

    func testShouldDeserializeAMove() {
        let move = Move(json: JSON(["id":1, "move":"N"]))
        XCTAssertNotNil(move)
    }

    func testShouldDeserializeAMoveAndRetrieveTheId() {
        let move = Move(json: JSON(["id":1, "move":"N"]))!
        XCTAssertEqual(move.getId(), 1)
    }

    func testShouldDeserializeAMoveAndRetrieveTheNorthDirection() {
        let move = Move(json: JSON(["id":1, "move":"N"]))!
        XCTAssertEqual(move.getDirection(), .North)
    }

    func testShouldDeserializeAMoveAndRetrieveTheSouthDirection() {
        let move = Move(json: JSON(["id":1, "move":"S"]))!
        XCTAssertEqual(move.getDirection(), .South)
    }

    func testShouldDeserializeAMoveAndRetrieveTheEstDirection() {
        let move = Move(json: JSON(["id":1, "move":"E"]))!
        XCTAssertEqual(move.getDirection(), .East)
    }

    func testShouldDeserializeAMoveAndRetrieveTheWestDirection() {
        let move = Move(json: JSON(["id":1, "move":"W"]))!
        XCTAssertEqual(move.getDirection(), .West)
    }

    func testShouldDeserializeAMoveAndRetrieveTheNoneDirection() {
        let move = Move(json: JSON(["id":1, "move":"O"]))!
        XCTAssertEqual(move.getDirection(), .None)
    }

    static var allTests : [(String, (MoveTests) -> () throws -> Void)] {
        return [
            ("testShouldHaveAMoveWithRightId", testShouldHaveAMoveWithRightId),
            ("testShouldHaveAMoveWithRightDirection", testShouldHaveAMoveWithRightDirection),
            ("testShouldDeserializeAMove", testShouldDeserializeAMove),
            ("testShouldDeserializeAMoveAndRetrieveTheId", testShouldDeserializeAMoveAndRetrieveTheId),
            ("testShouldDeserializeAMoveAndRetrieveTheNorthDirection", testShouldDeserializeAMoveAndRetrieveTheNorthDirection),
            ("testShouldDeserializeAMoveAndRetrieveTheSouthDirection", testShouldDeserializeAMoveAndRetrieveTheSouthDirection),
            ("testShouldDeserializeAMoveAndRetrieveTheEstDirection", testShouldDeserializeAMoveAndRetrieveTheEstDirection),
            ("testShouldDeserializeAMoveAndRetrieveTheWestDirection", testShouldDeserializeAMoveAndRetrieveTheWestDirection),
            ("testShouldDeserializeAMoveAndRetrieveTheNoneDirection", testShouldDeserializeAMoveAndRetrieveTheNoneDirection)
        ]
    }
}
