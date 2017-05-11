//
//  GameService.swift
//  MKTViewer
//
//  Created by Didier Plaindoux on 10/05/2017.
//
//

import Foundation
import MKTData
import SwiftyJSON

class SerializationError: Error {
    // Nothing
}

class MalformedURL: Error {
    // Nothing
}

/**
 * Read about https://code.bradymower.com/swift-3-apis-network-requests-json-getting-the-data-4aaae8a5efc0
 */

struct GameService {
    func getGame(onSuccess:@escaping (Game) -> (), onError:@escaping (Error) -> ())  {
        onError(SerializationError())
    }
}
