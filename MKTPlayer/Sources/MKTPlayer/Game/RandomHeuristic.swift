import MKTData

public struct RandomHeuristic: Heuristic {

    public init() {
        // Nothing
    }

    public func play(_ board:BoardGame) -> Direction {
        let directions = Direction.allValues
        return directions[randomNumber(directions.count)]
    }

}
