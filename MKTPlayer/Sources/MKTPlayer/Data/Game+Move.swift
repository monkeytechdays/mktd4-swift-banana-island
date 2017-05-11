import MKTData

extension Game {

    func move(_ move:Move) -> Game {
        let delta = self.directions(move.direction)

        switch delta {
        case (0,0): // kinda of optimization
            return self

        case (let dx,let dy):
            let board = self.getBoardGame()
                .findElements{ v in
                    v == move.getId()
                }
                .reduce(self.getBoardGame()) { (board, element) in
                    guard let _ = board.getElementAt(x:element.x + dx, y:element.y + dy)
                    else {
                        return board
                    }

                    return board
                        .setElementAt(x:element.x, y:element.y, 0)
                        .setElementAt(x:element.x + dx, y:element.y + dy, move.getId())
                }

            return Game(boardGame:board)
        }
    }

    private func directions(_ direction:Direction) -> (dx:Int,dy:Int) {
        switch direction {
        case .North:
            return (0,-1)
        case .South:
            return (0,+1)
        case .East:
            return (+1,0)
        case .West:
            return (-1,0)
        case .None:
            return (0,0)
        }

    }

}
