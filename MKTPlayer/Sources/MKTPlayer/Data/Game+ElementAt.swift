import MKTData

extension Game {

    func getElementAt(x: Int, y: Int) -> Int? {
        return self.getBoardGame().getElementAt(x:x, y:y)
    }

}
