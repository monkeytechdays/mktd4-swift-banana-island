import MKTData

import SwiftyJSON
import Kitura
import KituraNet
import KituraRequest

public class RegistrationService {

    let name:String
    let endpoint:String

    public init(name:String, endpoint:String) {
        self.name = name
        self.endpoint = endpoint
    }

    public func register(_ host:String, _ f: @escaping (Int?) -> ()) {
        Requester.post(
            "http://\(host)/player",
            ["name": name, "endpoint": endpoint]
        ) { status, json in
            if status == HTTPStatusCode.OK, let id = json?["id"].number {
                f(Int(id))
            } else {
                f(nil)
            }
        }
    }

}
