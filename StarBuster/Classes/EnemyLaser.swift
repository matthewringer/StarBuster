//
//  EnemyLaser.swift
//  StarBuster
//
//  Created by Matthew Ringer on 9/2/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class EnemyLaser:EnemyWeaponBehaviors {
    
    var texture:SKTexture?  = nil
    var color:SKColor      = SKColor.greenColor()
    var size:CGSize        = CGSize(width: 2.0,height: 5.0)
    
    private var laserCount = 1
    
    func spawn(weapon:EnemyWeapon, enemy:Enemy, controller:EnemyWeaponController) {
        
        for i in 1...laserCount {

            if enemy.position.x < (kViewSize.width) || enemy.position.x > 0 {
                if let laser = weapon.copy() as? EnemyWeapon {
                    // Copy from array
                    let laserSpacing = laser.size.width * 10
                    // Center the lasers on even numbers
                    let modOffset = CGFloat( (laserCount + 1) % 2 ) * laserSpacing / 2
                    let laserXOffset = laserSpacing * CGFloat(laserCount / 2) - modOffset
                    laser.position = CGPoint(x: enemy.position.x + laserSpacing * CGFloat(i) - laserXOffset, y: enemy.position.y + laser.size.height)
                    controller.addChild(laser)
                }
            }
        }
    }
    
    func update(weapon:EnemyWeapon, delta: NSTimeInterval) {
        // Move verticallhy up the screen based on device type
        weapon.position.y =  kDeviceTablet ? weapon.position.y - CGFloat(delta * 60 *  4) : weapon.position.y - CGFloat(delta * 60 *  2)
        
        if weapon.position.y < (0 - self.size.height) {
            weapon.removeFromParent()
        }
    }
    
    func destroy(weapon:EnemyWeapon) {
    
    }
}
