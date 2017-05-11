import XCTest
import SwiftyJSON

@testable import MKTData

class PlayerTests: XCTestCase {

    // builder -- useless ? probably !

    func testShouldHaveAPlayerWithRightId() {
        let player = Player(id:1, name:"Doe", score:42)
        XCTAssertEqual(player.getId(), 1)
    }

    func testShouldHaveAPlayerWithRightName() {
        let player = Player(id:1, name:"Doe", score:42)
        XCTAssertEqual(player.getName(), "Doe")
    }

    func testShouldHaveAPlayerWithRightScore() {
        let player = Player(id:1, name:"Doe", score:42)
        XCTAssertEqual(player.getScore(), 42)
    }

    // serialize

    func testShouldHaveASerializedPlayerWithRightId() {
        let player = Player(id:1, name:"Doe", score:42).serialize()
        XCTAssertEqual(player["id"] as? Int, 1)
    }

    func testShouldHaveASerializedPlayerWithRightName() {
        let player = Player(id:1, name:"Doe", score:42).serialize()
        XCTAssertEqual(player["name"] as? String, "Doe")
    }

    func testShouldHaveASerializedPlayerWithRightScore() {
        let player = Player(id:1, name:"Doe", score:42).serialize()
        XCTAssertEqual(player["score"] as? Int, 42)
    }

    // deserialize

    func testShouldHaveADeSerializedPlayerWithRightId() {
        let player = Player(json: JSON(Player(id:1, name:"Doe", score:42).serialize()))
        XCTAssertEqual(player?.getId(), 1)
    }

    func testShouldHaveADeSerializedPlayerWithRightName() {
        let player = Player(json: JSON(Player(id:1, name:"Doe", score:42).serialize()))
        XCTAssertEqual(player?.getName(), "Doe")
    }

    func testShouldHaveADeSerializedPlayerWithRightScore() {
        let player = Player(json: JSON(Player(id:1, name:"Doe", score:42).serialize()))
        XCTAssertEqual(player?.getScore(), 42)
    }

    // failure during serialize

    func testShouldNotSerializePlayerWhenDefinitionisComplete() {
        let player = Player(json: JSON(["id":1, "name":"Doe", "score": 42]))
        XCTAssertNotNil(player)
    }

    func testShouldNotSerializePlayerWhenDefinitionisPartial() {
        let player = Player(json: JSON(["id":1]))
        XCTAssertNil(player)
    }

    func testShouldNotSerializePlayerWhenTypeIsNotCorrect() {
        let player = Player(json: JSON(["id":1, "name":1]))
        XCTAssertNil(player)
    }

    static var allTests : [(String, (PlayerTests) -> () throws -> Void)] {
        return [
            ("testShouldHaveAPlayerWithRightId", testShouldHaveAPlayerWithRightId),
            ("testShouldHaveAPlayerWithRightName", testShouldHaveAPlayerWithRightName),
            ("testShouldHaveAPlayerWithRightScore", testShouldHaveAPlayerWithRightScore),
            ("testShouldHaveASerializedPlayerWithRightId", testShouldHaveASerializedPlayerWithRightId),
            ("testShouldHaveASerializedPlayerWithRightName", testShouldHaveASerializedPlayerWithRightName),
            ("testShouldHaveASerializedPlayerWithRightScore", testShouldHaveASerializedPlayerWithRightScore),
            ("testShouldHaveADeSerializedPlayerWithRightId", testShouldHaveADeSerializedPlayerWithRightId),
            ("testShouldHaveADeSerializedPlayerWithRightName", testShouldHaveADeSerializedPlayerWithRightName),
            ("testShouldHaveADeSerializedPlayerWithRightScore", testShouldHaveADeSerializedPlayerWithRightScore),
            ("testShouldNotSerializePlayerWhenDefinitionisComplete", testShouldNotSerializePlayerWhenDefinitionisComplete),
            ("testShouldNotSerializePlayerWhenDefinitionisPartial", testShouldNotSerializePlayerWhenDefinitionisPartial),
            ("testShouldNotSerializePlayerWhenTypeIsNotCorrect", testShouldNotSerializePlayerWhenTypeIsNotCorrect)
        ]
    }
}
