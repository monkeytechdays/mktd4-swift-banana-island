/**
 * Main Entry
 */

import Foundation

import MKTPlayer

import HeliumLogger
import LoggerAPI
import SwiftyJSON

guard CommandLine.arguments.count == 2
else {
    print("usage: \(CommandLine.arguments[0]) configuration-file")
    exit(1)
}

HeliumLogger.use()

let contents = try String(contentsOfFile: CommandLine.arguments[1], encoding: .utf8)

guard let json = contents.data(using:String.Encoding.utf8).flatMap({JSON(data: $0)})
else {
    Log.error("configuration file is not a valid json file")
    exit(1)
}

guard let playerName = json["name"].string.flatMap({$0 as String})
else {
    Log.error("name not found in configuration file")
    exit(1)
}

guard let playerPortNumber = json["player"]["port"].number.flatMap({Int($0)})
else {
    Log.error("player.port not found in configuration file")
    exit(1)
}

guard let playerHost = json["player"]["host"].string.flatMap({$0 as String})
else {
    Log.error("player.host not found in configuration  file")
    exit(1)
}

guard let refereePortNumber = json["referee"]["port"].number.flatMap({Int($0)})
else {
    Log.error("referee.port not found in configuration file")
    exit(1)
}

guard let refereeHost = json["referee"]["host"].string.flatMap({$0 as String})
else {
    Log.error("referee.host not found in configuration file")
    exit(1)
}

let playerEndPoint = "\(playerHost):\(playerPortNumber)"
let refereeEndPoint = "\(refereeHost):\(refereePortNumber)"

var gameService = GameService(teamId:0, endpoint:refereeEndPoint, heuristic:RandomHeuristic())

let application = Application()
            <| AliveService()
            <| gameService

RegistrationService(name:playerName, endpoint:playerEndPoint).register(refereeEndPoint) { teamId in
    guard let id = teamId else {
        Log.verbose("Registration rejected by \(refereeEndPoint)")
        exit(2)
    }

    gameService.teamId = id

    Log.info("Registration accepted with team identifier \(id)")
}

application.start(port: playerPortNumber)
