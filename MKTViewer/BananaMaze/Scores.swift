//
//  ScorePanel.swift
//  MKTViewer
//
//  Created by Didier Plaindoux on 11/05/2017.
//
//

import Foundation

import SpriteKit
import GameplayKit
import UIKit
import MKTData

class Scores {
    
    private let rootNode: SKNode
    private let panelScore:SKShapeNode
    private let scoreLabels:[SKLabelNode]
    
    private var presented: Int
    
    init(rootNode: SKNode) {
        self.rootNode = rootNode
        
        self.scoreLabels = [SKLabelNode(fontNamed: "Chalkduster"),
                            SKLabelNode(fontNamed: "Chalkduster"),
                            SKLabelNode(fontNamed: "Chalkduster"),
                            SKLabelNode(fontNamed: "Chalkduster")]

        self.panelScore = SKShapeNode(rect: CGRect(x: -UIScreen.main.bounds.width/2,
                                                   y: UIScreen.main.bounds.height/2 - 30,
                                                   width: UIScreen.main.bounds.width,
                                                   height: 30))
        
        self.presented = 0
    }

    func prepareScores() {
        panelScore.fillColor = .init(red: 0.4, green: 0.5, blue: 0.6, alpha: 0.8)
        panelScore.strokeColor = panelScore.fillColor
        
        rootNode.addChild(panelScore)
        
        self.presented = 0
    }

    func presentScores(players:[Player]) {
        if presented < players.count {
            for index in presented..<players.count {
                prepareScore(player: players[index])
            }
            
            self.presented = players.count
        } else {
            for player in players {
                presentScore(player: player)
            }
        }
    }
    
    //
    // Private behaviors
    //
    
    private func prepareScore(player:Player) {
        let index = player.getId()-3
        let pictScore = SKSpriteNode(imageNamed: "monkey\(index+1)")
        let x =  -UIScreen.main.bounds.width/2 + 15 + CGFloat(index*80)
        let y = UIScreen.main.bounds.height/2 - 15
        
        pictScore.size = CGSize(width: 49, height: 49)
        pictScore.position = CGPoint(x: x, y: y)
        pictScore.setScale(0.5)
        
        let playerName = SKLabelNode(fontNamed: "Chalkduster")
        playerName.text = "\(player.getName())"
        playerName.horizontalAlignmentMode = .left
        playerName.verticalAlignmentMode = .center
        playerName.position = CGPoint(x: x + 15, y: y - 8)
        playerName.setScale(0.2)
        
        
        scoreLabels[index].text = "\(player.getScore())"
        scoreLabels[index].horizontalAlignmentMode = .left
        scoreLabels[index].verticalAlignmentMode = .center
        scoreLabels[index].position = CGPoint(x: x + 15 ,y: y + 5)
        scoreLabels[index].setScale(0.5)
        
        panelScore.addChild(pictScore)
        panelScore.addChild(playerName)
        panelScore.addChild(scoreLabels[index])
    }

    private func presentScore(player:Player) {
        let index = player.getId()-3

        scoreLabels[index].text = "\(player.getScore())"
    }

}
