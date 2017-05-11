import Kitura
import KituraNet
import KituraRequest

import Foundation

public class AliveService : Service {

    public init() {
        // Nothing
    }

    public func addRoutes(_ router: Router) {
        router.get("/") { request, response, _ in
            try response.status(.OK)
                    .send(json: ["time": Date().timeIntervalSince1970])
                    .end()
        }
    }

}
