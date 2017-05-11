import XCTest

import Dispatch
import MKTData

@testable import MKTPlayer

class RegistrationServiceTests: XCTestCase {

    private let port = 9090
    private var application: Application?

    override func setUp() {
        super.setUp()
        self.application = Application() <| RefereeServiceMock()

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

    func testShouldBeAbleToRegisterANewPlayer() {
        RegistrationService(name:"Totoro", endpoint:"localhost:\(self.port)").register("localhost:\(self.port)") { teamId in
            XCTAssertNotNil(teamId)
        }
    }

    func testShouldBeAbleToRegisterANewPlayerAndRetreiveTheId() {
        RegistrationService(name:"Totoro", endpoint:"localhost:\(self.port)").register("localhost:\(self.port)") { teamId in
            XCTAssertEqual(teamId, 42)
        }
    }
    func testShouldNotBeAbleToRegisterANewPlayer() {
        RegistrationService(name:"Totoro", endpoint:"localhost:\(self.port)").register("localhost:\(self.port+1)") { teamId in
            XCTAssertNil(teamId)
        }
    }

    static var allTests : [(String, (RegistrationServiceTests) -> () throws -> Void)] {
        return [
            ("testShouldBeAbleToRegisterANewPlayer", testShouldBeAbleToRegisterANewPlayer),
            ("testShouldBeAbleToRegisterANewPlayerAndRetreiveTheId", testShouldBeAbleToRegisterANewPlayerAndRetreiveTheId),
            ("testShouldNotBeAbleToRegisterANewPlayer", testShouldNotBeAbleToRegisterANewPlayer)
        ]
    }

}
