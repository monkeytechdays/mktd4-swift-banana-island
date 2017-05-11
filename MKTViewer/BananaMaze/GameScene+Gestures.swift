//
//  GameScene+Gestures.swift
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

extension GameScene {
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        clickLocation = touch.location(in: self)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentLocation = touch.location(in: self)
        
        mapBackground?.position.x += currentLocation.x - clickLocation.x
        mapBackground?.position.y += currentLocation.y - clickLocation.y
        
        clickLocation = currentLocation
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickLocation = .zero
    }

}
