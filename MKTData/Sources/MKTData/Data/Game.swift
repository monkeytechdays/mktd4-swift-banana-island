/**
 * MKTD#4
 */

public class Game {

    private let boardGame: BoardGame
    private let players: [Player]

    required public init(boardGame:BoardGame, players: [Player]) {
        self.boardGame = boardGame
        self.players = players
    }

    public init(boardGame:BoardGame) {
        self.boardGame = boardGame
        self.players = [Player]()
    }

    public func getBoardGame() -> BoardGame {
        return self.boardGame
    }

    public func getPlayers() -> [Player] {
        return self.players
    }

}
