//
//  StatController.swift
//  StarBuster
//
//  Created by Matthew Ringer on 8/14/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class BonusController:SKNode {
    
    // MARK: - Private class constants
    private let star = Bonus(behaviors: Star())
    private let life = Bonus(behaviors: OneUp())
    
    // MARK: - Private class variables
    private var sendingBonuses = false
    private var movingBonuses = false
    private var frameCount = 0.0
    private var bonusArray = [SKSpriteNode]()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        
        self.setupBonusController()
    }
    
    // MARK: - Setup
    private func setupBonusController() {
        bonusArray = [star, life]
    }
    
    // MARK: - Update
    func update(delta delta:NSTimeInterval) {
        // Is it time to send the Bonus?
        if self.sendingBonuses {
            self.frameCount += delta
            
            if self.frameCount >= 3.0 {
                // Spawn a Bonus
                self.spawnBonus()
                self.frameCount = 0.0
            }
        }
        
        if self.movingBonuses {
            for node in self.children {
                if let bonus = node as? Bonus {
                    bonus.update(delta: delta)
                }
            }
        }
    }
    
    // MARK: - Spawn
    private func spawnBonus() {
        if self.sendingBonuses {
            let startX = RandomFloatRange(min: 0, max: kViewSize.width)
            let startY = kViewSize.height * 1.25
            
            let randomBonusIndex = RandomIntegerBetween(min: 0, max: self.bonusArray.count - 1)
            if let bonus = self.bonusArray[randomBonusIndex].copy() as? Bonus {
                bonus.position = CGPoint(x: startX, y: startY)
                bonus.drift = RandomFloatRange(min: -0.25, max: 0.25)
                self.addChild(bonus)
            }
        }
    }
    
    // MARK: - Actions
    func startSendingBonuses() {
        self.sendingBonuses = true
        self.movingBonuses = true
    }
    
    func stopSendingBonuses() {
        self.sendingBonuses = false
        self.movingBonuses = false
    }
    
    func gameOver() {
        for node in self.children {
            if let bonus = node as? Bonus {
                bonus.gameOver()
            }
        }
    }
}
