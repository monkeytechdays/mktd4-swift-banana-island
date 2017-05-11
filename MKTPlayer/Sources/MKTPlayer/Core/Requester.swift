import Kitura
import KituraNet
import KituraRequest
import SwiftyJSON
import LoggerAPI
import Foundation

public struct Requester {

    static public func serverResponse(_ request:RouterRequest, _ response:RouterResponse, _ f: @escaping (JSON?) throws -> ()) throws {

        Log.verbose("Request \(request.parsedURL)")

        guard let parsedBody = BodyParser.parse(request, contentType:request.headers["Content-Type"])
        else {
            try f(nil)
            return
        }

        switch(parsedBody) {
        case .json(let jsonBody):
            try f(jsonBody)
        default:
            try f(nil)
        }
    }

    static public func get(_ path:String, headers:[String:String]?=nil, _ f: @escaping (HTTPStatusCode?, JSON?) -> ()) {
        let request = KituraRequest.request(
            Request.Method.get,
            path,
            headers:headers
        )

        self.clientResponse(request, f);
    }

    static public func delete(_ path:String, headers:[String:String]?=nil, _ f: @escaping (HTTPStatusCode?, JSON?) -> ()) {
        let request = KituraRequest.request(
            Request.Method.delete,
            path,
            headers:headers
        )

        self.clientResponse(request, f);
    }

    static public func post(_ path:String, headers:[String:String]?=nil, _ value:Request.Parameters, _ f: @escaping (HTTPStatusCode?, JSON?) -> ()) {
        let request = KituraRequest.request(
            Request.Method.post,
            path,
            parameters: value,
            encoding: JSONEncoding.default,
            headers:headers
        )

        self.clientResponse(request, f)
    }

    static private func clientResponse(_ request:Request, _ f: @escaping (HTTPStatusCode?, JSON?) -> ()) {
        request.response { _, response, data, _ in
            f(response?.httpStatusCode, data.flatMap{ data in JSON(data:data) })
        }
    }

}
