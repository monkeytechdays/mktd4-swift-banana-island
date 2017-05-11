public class BoardGame {

    let size : (Int,Int)
    let board : [[Int]]

    public init?(board : [[Int]]) {
        guard let size = BoardGame.checkConsistencyAndGetSize(board: board)
        else {
            return nil
        }

        self.size = size
        self.board = board
    }

    public func getDimensions() -> (x:Int,y:Int) {
        if board.count == 0 {
            return (0,0)
        } else {
            return (board[0].count, board.count)
        }
    }

    public func getElementAt(x:Int, y:Int) -> Int? {
        return board.get(y)?.get(x)
    }

    public func getBoardGame() -> [[Int]] {
        return self.board
    }

    //
    // Private behaviors
    //

    private static func checkConsistencyAndGetSize(board : [[Int]]) -> (x:Int,y:Int)? {
        let rows = board.count

        if rows == 0 {
            return (0,0)
        }

        let colums = board[0].count

        if board.filter({ $0.count == colums }).count == rows {
            return (rows, colums)
        }

        return nil
    }

}
