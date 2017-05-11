/**
 * MKTD#4
 */

import SwiftyJSON

public extension Player {

    convenience public init?(json: JSON) {
        guard let id = json["id"].number,
			let name = json["name"].string,
            let score = json["score"].number
		else {
			return nil
		}

        self.init(id:Int(id), name:name as String, score: Int(score))
    }

    public func serialize() -> [String:Any] {
        return [
            "id": self.getId(),
            "name": self.getName(),
            "score": self.getScore()
        ]
    }

}
