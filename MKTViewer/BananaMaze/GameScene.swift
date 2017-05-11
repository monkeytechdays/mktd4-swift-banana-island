//
//  GameScene.swift
//  BananaMaze
//
//  Created by Didier Plaindoux on 25/04/2017.
//
//

import SpriteKit
import GameplayKit
import UIKit
import MKTData

class GameScene: SKScene {

    var game: Game?
    var previousDimension:(x:Int,y:Int)?

    var mapBackground:SKTileMapNode?
    var mapForeground:SKTileMapNode?

    var scores:Scores?
    
    var previousScale = CGFloat(1.0)
    var initialScale = CGFloat(1.0)
    var setup: Bool = true

    var clickLocation:CGPoint = .zero

    func loadSceneNodes() -> Bool {
        guard let dimension = (self.game?.getBoardGame().getDimensions())
        else {
            return false;
        }
        
        if dimension.x == previousDimension?.x && dimension.y == previousDimension?.y {
            return true
        }
        
        self.previousDimension = dimension
        
        self.removeAllChildren()
        
        self.scores = .init(rootNode: self)
        self.mapBackground = createTileMap(node:self, tileSet:"MKT Tile Set", size:dimension)
        self.mapForeground = createTileMap(node:self.mapBackground!, tileSet:"MKT Tile Set", size:dimension)
        
        let screenSize = UIScreen.main.bounds
        
        self.initialScale = min(screenSize.width  / CGFloat((dimension.x+3) * 48),
                                screenSize.height / CGFloat((dimension.y+3) * 48))
        
        self.mapBackground?.setScale(self.initialScale)
        
        self.initObjects()
        
        return true
    }

    func initObjects() {
        guard let tileGroups = mapBackground?.tileSet.tileGroups
            else {
                fatalError("Object Tiles Tile Set not found")
        }
        
        if let empty = tileGroups.first(where: {$0.name == "empty"}),
            let wall = tileGroups.first(where: {$0.name == "wall"}) {
            mapBackground?.fill(with: empty)
            mapForeground?.fill(with: wall)
        }
        
        self.scores?.prepareScores()
    }

    func setupObjects() {
        let columns = self.game?.getBoardGame().getDimensions().x ?? 32
        let rows = self.game?.getBoardGame().getDimensions().y ?? 32

        guard let tileGroups = mapBackground?.tileSet.tileGroups
            else {
            fatalError("Object Tiles Tile Set not found")
        }

        for column in 0..<columns {
            for row in 0..<rows {
                let element = self.game?.getBoardGame().getElementAt(x: column, y: row)

                if element == 2, let wall = tileGroups.first(where: {$0.name == "wall"}) {
                    mapForeground?.setTileGroup(wall, forColumn: column+1, row: rows - row)
                } else if element == 1,
                    let banana = tileGroups.first(where: {$0.name == "banana"}) {
                    mapForeground?.setTileGroup(banana, forColumn: column+1, row: rows - row)
                } else if element ?? 0 > 2,
                    let monkey = tileGroups.first(where: {$0.name == "monkey\((element ?? 0) - 2)"}) {
                    mapForeground?.setTileGroup(monkey, forColumn: column+1, row: rows - row)
                } else if let empty = tileGroups.first(where: {$0.name == "empty"}) {
                    mapForeground?.setTileGroup(empty, forColumn: column+1, row: rows - row)
                }
            }
        }
        
        self.scores?.presentScores(players: self.game?.getPlayers() ?? [Player]())
    }
    
    func pinched(sender:UIPinchGestureRecognizer){
        guard let ground =  mapBackground
            else {
            return
        }
        
        if sender.scale > previousScale {
            previousScale = sender.scale
            ground.run(SKAction.scale(by:1.05, duration:0))
        }
        
        if sender.scale < previousScale {
            previousScale = sender.scale
            ground.run(SKAction.scale(by:0.95, duration:0))
        }
    }

    func tapped(sender:UITapGestureRecognizer){
        guard let ground =  mapBackground
            else {
                return
        }

        ground.setScale(self.initialScale)
        ground.position.x = 0
        ground.position.y = 0
    }


    override func didMove(to view: SKView) {
        if self.loadSceneNodes() {
            self.setupObjects()
        }

        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(self.pinched(sender:)))
        view.addGestureRecognizer(pinch)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }

    private func createTileMap(node: SKNode, tileSet:String, size:(x:Int,y:Int)) -> SKTileMapNode {
        guard let tileSet = SKTileSet(named: tileSet) else {
            fatalError("Object Tiles Tile Set not found")
        }

        let objectsTileMap = SKTileMapNode(tileSet: tileSet,
                                           columns: size.x+2,
                                           rows: size.y+2,
                                           tileSize: CGSize(width:49, height: 49))

        node.addChild(objectsTileMap)

        return objectsTileMap
    }

    public func setupGame() {
        self.setup = false
        
        GameService().getGame(
            onSuccess: { game in
                self.game = game

                if self.loadSceneNodes() {
                    self.setupObjects()
                }
                
                self.setup = true
                
                sleep(1)
            },
            onError: { error in
                self.game = nil
                self.previousDimension = nil
                
                self.setup = true
                
                sleep(5)
            }
        )
    }
    
    override func update(_ currentTime: TimeInterval) {
        if setup {
            self.setupGame()
        }
    }
}
