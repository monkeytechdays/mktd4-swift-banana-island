class Move {

    let id : Int
    let direction : Direction

    init(id:Int, direction:Direction) {
        self.id = id
        self.direction = direction
    }

    func getId() -> Int {
        return self.id
    }

    func getDirection() -> Direction {
        return self.direction
    }
}
