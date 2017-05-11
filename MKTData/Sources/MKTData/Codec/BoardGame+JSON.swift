/**
 * MKTD#4
 */

import Foundation
import SwiftyJSON

public extension BoardGame {

    convenience public init?(json: JSON) {
        guard let board = json.array
        else {
            return nil
        }

        self.init(json: board)
    }

    convenience public init?(json: [JSON]) {
        guard let board = json.transform({ e in e.array?.transform(BoardGame.element) })
        else {
            return nil
        }

        self.init(board: board)
    }

    private static func element(element:JSON) -> Int? {
        guard let value = element.number
        else {
            return nil
        }

        return Int(value)
    }

    public func serialize() -> [[Any]] {
        return self.getBoardGame()
    }
}
