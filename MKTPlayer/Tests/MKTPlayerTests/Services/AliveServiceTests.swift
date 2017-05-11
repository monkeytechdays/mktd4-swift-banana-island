import XCTest

import Dispatch
import MKTData
import SwiftyJSON
import KituraNet

@testable import MKTPlayer

class AliveServiceTests: XCTestCase {

    private let port = 9090
    private var application: Application?

    override func setUp() {
        super.setUp()
        self.application = Application() <| AliveService()

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

    func testShouldCallRootWithStatus200() {
        Requester.get(self.getURI()) { status, json in
            XCTAssertEqual(status, HTTPStatusCode.OK)
        }
    }

    func testShouldCallRootWithResponse() {
        Requester.get(self.getURI()) { status, json in
            XCTAssertEqual(status, HTTPStatusCode.OK)
            XCTAssertNotNil(json.flatMap{ json in json["time"].number })
        }
    }

    static var allTests : [(String, (AliveServiceTests) -> () throws -> Void)] {
        return [
            ("testShouldCallRootWithStatus200", testShouldCallRootWithStatus200),
            ("testShouldCallRootWithResponse", testShouldCallRootWithResponse)
        ]
    }

    //
    // Private behaviors
    //

    private func getURI() -> String {
        return "http://localhost:\(self.port)/"
    }

}
