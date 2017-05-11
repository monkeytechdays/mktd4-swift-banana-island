import MKTData

extension BoardGame {

    func setElementAt(x:Int, y:Int,  _ newValue:Int ) -> BoardGame {
        return BoardGame(board:self.getBoardGame().enumerated().map{ (j,c) in
            j == y ? c.enumerated().map{ (i,currentValue) in i == x ? newValue : currentValue } : c
        })!
    }

}
