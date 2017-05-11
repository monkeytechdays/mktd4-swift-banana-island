import MKTPlayer

import Kitura

class RefereeServiceMock : Service {

    func addRoutes(_ router: Router) {
        router.post("/player") { request, response, next in
            try response.status(.OK).send(json: ["id": 42]).end()
        }

        router.post("/map") { request, response, next in
            try response.status(.noContent).end()
        }

    }

}
