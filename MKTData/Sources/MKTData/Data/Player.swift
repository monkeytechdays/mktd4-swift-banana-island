public class Player {
    private let id : Int
    private let name : String
    private let score : Int

    public init(id: Int, name: String, score: Int) {
        self.id = id
        self.name = name
        self.score = score
    }

    public func getId() -> Int {
        return self.id
    }

    public func getName() -> String {
        return self.name
    }

    public func getScore() -> Int {
        return self.score
    }
}
