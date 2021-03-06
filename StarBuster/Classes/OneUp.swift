//
//  OneUp.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class OneUp:BonusBehaviors {
    
    var texture:SKTexture = SKTexture()
    
    init(){
        self.texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.PlayerLives)
    }
    
    func bonusPickedUpBy(_ player:Player, statusBar:StatusBar) {
        player.lives += 1
        statusBar.updateLives(lives: player.lives)
        
        let position = CGPoint(x: player.position.x, y: player.position.y + (player.texture?.size().height)!)
        player.parent?.addChild(FloatLabel.spawn(position, text: "1UP!"))
    }
}
