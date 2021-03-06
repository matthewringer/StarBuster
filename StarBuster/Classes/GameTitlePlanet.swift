//
//  GameTitle.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/7/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class GameTitlePlanet:SKSpriteNode{
    
    //MARK: - Init
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    fileprivate override init(texture:SKTexture?, color: UIColor, size: CGSize){
        super.init(texture: texture, color: color, size: size)
    }
    
    convenience init() {
        let texture = GameTextures.sharedInstance.textureWithName(name: SpriteName.TitleGamePlanet)
        self.init(texture: texture, color: SKColor.white, size: texture.size())
        self.setupGameTitlePlanet()
    }
    
    fileprivate func setupGameTitlePlanet(){
        self.position = CGPoint(x: kViewSize.width / 2, y: kViewSize.height / 2)
        self.zPosition = GameLayer.BackgroundHigh
    }
}
