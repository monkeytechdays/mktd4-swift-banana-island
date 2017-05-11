import MKTData

public protocol Heuristic {
    func play(_ board:BoardGame) -> Direction
}
