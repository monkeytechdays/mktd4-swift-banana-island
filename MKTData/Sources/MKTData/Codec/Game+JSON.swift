/**
 * MKTD#4
 */

import SwiftyJSON

public extension Game {

    convenience public init?(json : JSON) {
        guard let boardGame =  BoardGame(json:json["map"]),
            let players = json["gamers"].array?.transform({ j in Player(json:j) })
		else {
			return nil
		}

        self.init(boardGame:boardGame, players:players)
    }

    public func serialize() -> [String:Any] {
        return [
            "map": self.getBoardGame().serialize(),
            "gamers": self.getPlayers().map{ e in e.serialize() }
        ]
    }

}
