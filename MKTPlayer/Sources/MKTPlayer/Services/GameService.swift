import Foundation
import Dispatch

import MKTData

import SwiftyJSON
import Kitura
import KituraNet
import KituraRequest
import LoggerAPI

public class GameService : Service {

    private let endpoint:String
    private let executor:DispatchQueue
    private let heuristic:Heuristic

    public var teamId:Int
    private var game:Game?

    public init(teamId:Int, endpoint:String, heuristic:Heuristic? = nil) {
        self.executor = DispatchQueue(label: "Game Dispatcher")
        self.endpoint = endpoint
        self.heuristic = heuristic ?? RandomHeuristic()

        self.teamId = teamId
        self.game = nil
    }

    public func addRoutes(_ router: Router) {
        router.post("/map"){ rq, rs, ne in try self.mapRegistration(rq,rs,ne) }
        router.post("/map/:uuid"){ rq, rs, ne in try self.playerTurn(rq,rs,ne) }
        router.delete("/map"){ rq, rs, ne in try self.mapDeletion(rq,rs,ne) }
    }

    private func mapRegistration(_ request: RouterRequest, _ response: RouterResponse, _ next: @escaping () -> Void) throws {
        try Requester.serverResponse(request, response) { json in

            guard let boardGame = json?["map"].array.flatMap({ json in BoardGame(json:json) })
            else {
                return try response.status(.badRequest).end()
            }

            self.game = Game(boardGame:boardGame, players:[])

            try response.status(.noContent).end()
        }
    }

    public func playerTurn(_ request: RouterRequest, _ response: RouterResponse, _ next: @escaping () -> Void) throws {
        try Requester.serverResponse(request, response) { json in

            guard let board = self.game?.getBoardGame(),
                let session = request.parameters["uuid"],
                let moves = json?["moves"].array?.transform({ j in Move(json:j) })
            else {
                return try response.status(.badRequest).end()
            }

            try response.status(.noContent).end()

            self.executor.async() {
                self.game = self.game.map{ game in
                    moves.reduce(game) { (game,move) in game.move(move) }
                }

                self.playerProposition(board, session)
            }
        }
    }

    public func mapDeletion(_ request: RouterRequest, _ response: RouterResponse, _ next: @escaping () -> Void) throws {
        self.game = nil

        try response.status(.noContent).end()
    }

    private func playerProposition(_ board:BoardGame, _ session:String) {
        let direction = self.heuristic.play(board)

        Requester.post(
            "http://\(self.endpoint)/map",
            headers:["uuid":session],
            ["move": direction.rawValue]
        ) { status,_ in
            if status == HTTPStatusCode.noContent {
                Log.verbose("Move accepted goto \(direction.rawValue)")
                self.game = self.game.map{ game in
                    game .move(Move(id:self.teamId, direction:direction))
                }
            } else {
                Log.verbose("Move rejected cannot goto \(direction.rawValue)")
            }
        }
    }
}
