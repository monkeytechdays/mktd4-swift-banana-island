import XCTest

import Dispatch
import MKTData
import SwiftyJSON
import KituraNet

@testable import MKTPlayer

class GameServiceTests: XCTestCase {

    private let port = 9090
    private var application: Application?

    override func setUp() {
        super.setUp()
        self.application = Application()
                            <| GameService(teamId:1, endpoint: self.getURI())

        DispatchQueue(label: "Application Dispatcher").async() {
            self.application?.start(port:self.port)
        }

        // Stupid sleep to remove ASAP
        // sleep(1)
    }

    override func tearDown() {
        super.tearDown()
        self.application?.stop()
    }

    func testShouldCreateAMap() {
        Requester.post(
            "\(self.getURI())/map",
            ["map":[[1],[1]]]
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.noContent)
        }
    }

    func testShouldNotCreateAMap() {
        Requester.post(
            "\(self.getURI())/map",
            ["map":[[],[1]]]
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.badRequest)
        }
    }

    func testShouldPlay() {
        Requester.post(
            "\(self.getURI())/map",
            ["map":[[1],[1]]]
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.noContent)
        }

        Requester.post(
            "\(self.getURI())/map/1234",
            ["moves":[]]
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.noContent)
        }
    }

    func testShouldNotPlay() {
        Requester.post(
            "\(self.getURI())/map/1234",
            ["moves":[]]
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.badRequest)
        }
    }

    func testShouldEndGame() {
        Requester.delete(
            "\(self.getURI())/map"
        ) { status, _ in
            XCTAssertEqual(status, HTTPStatusCode.noContent)
        }
    }

    static var allTests : [(String, (GameServiceTests) -> () throws -> Void)] {
        return [
            ("testShouldCreateANewMap", testShouldCreateAMap),
            ("testShouldNotCreateANewMap", testShouldNotCreateAMap),
            ("testShouldPlay", testShouldPlay),
            ("testShouldNotPlay", testShouldNotPlay),
            ("testShouldEndGame", testShouldEndGame)
        ]
    }

    //
    // Private behaviors
    //

    private func getURI() -> String {
        return "http://localhost:\(self.port)"
    }

}
