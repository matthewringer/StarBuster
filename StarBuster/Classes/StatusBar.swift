//
//  StatusBar.swift
//  SpaceRunner
//
//  Created by Matthew Ringer on 8/9/16.
//  Copyright © 2016 Matthew Ringer. All rights reserved.
//

import SpriteKit

class StatusBar:SKNode {
    // MARK: - Private Class Variables
    fileprivate var statusBarBackground = SKSpriteNode()
    fileprivate var scoreLabel = SKLabelNode()
    fileprivate var starsCollectedIcon = SKSpriteNode()
    fileprivate var starsCollectedLabel = SKLabelNode()
    
    
    // MARK: - Internal Class Constants
    let pauseButton = PauseButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    convenience init(lives: Int, score: Int, stars:Int){
        self.init()
        self.setupStatusBar()
        self.setupStatusBarBackground()
        self.setupStatusBarScore(score)
        self.updateLives(lives: lives)
        self.setupStatusBarStarsCollected(collected: stars)
        self.setupPauseButton()
    }
    
    //MARK: - Setup
    fileprivate func setupStatusBar() {
        
    }
    
    fileprivate func setupStatusBarBackground() {
        // Make a GCRect that is as wide as the screen and 5% of the height of the screen
        let statusBarBackgoundSize = CGSize(width: kViewSize.width, height: kViewSize.height * 0.05)
        
        // Make a sprite color that is black in color and the size of the statusBarBackground
        self.statusBarBackground = SKSpriteNode(color: SKColor.black, size: statusBarBackgoundSize)
        
        // Make the anchor point 0,0 so that it is postioned to the lower leftcorner
        self.statusBarBackground.anchorPoint = CGPoint.zero
    
        // Position the status bar at the left edge and 95% up the screen
        self.statusBarBackground.position = CGPoint(x:0, y: kViewSize.height * 0.95)
        
        // Set the Alpha to 75% opacity
        self.statusBarBackground.alpha = 0.75
        
        self.addChild(statusBarBackground)
    }
    
    fileprivate func setupStatusBarScore(_ score: Int) {
        let scoreText = GameFonts.sharedInstance.createLabel(string: "Score:", labelType: GameFonts.LabelType.statusBar)
        scoreText.position = CGPoint(x:self.statusBarBackground.size.width * 0.6, y: self.statusBarBackground.size.height / 2)
        self.statusBarBackground.addChild(scoreText)
        
        // Score Lable
        self.scoreLabel = GameFonts.sharedInstance.createLabel(string: String(score), labelType: GameFonts.LabelType.statusBar)
        let offsetX = self.statusBarBackground.size.width * 0.75
        let offsetY = self.statusBarBackground.size.height / 2
        self.scoreLabel.position = CGPoint(x: offsetX, y: offsetY)
        self.statusBarBackground.addChild(self.scoreLabel)
    }
    
    fileprivate func setupStatusBarStarsCollected(collected: Int) {
        // Collected stars icon
        self.starsCollectedIcon = GameTextures.sharedInstance.spriteWithName(name: SpriteName.StarIcon)
        let starOffsetX = self.statusBarBackground.size.width / 2 - self.starsCollectedIcon.size.width * 2
        let starOffsetY = self.statusBarBackground.size.height / 2
        self.starsCollectedIcon.position = CGPoint(x: starOffsetX, y: starOffsetY)
        self.starsCollectedIcon.name = SpriteName.StarIcon
        self.statusBarBackground.addChild(self.starsCollectedIcon)

        // Collected Stars Lable
        self.starsCollectedLabel = GameFonts.sharedInstance.createLabel(string: String(collected), labelType: GameFonts.LabelType.statusBar)
        let labelOffsetX = self.statusBarBackground.size.width / 2
        let lableOffsetY = self.statusBarBackground.size.height / 2
        self.starsCollectedLabel.position = CGPoint(x: labelOffsetX, y: lableOffsetY)
        
        self.statusBarBackground.addChild(self.starsCollectedLabel)
    }
    
    fileprivate func setupPauseButton() {
        self.addChild(self.pauseButton)
    }
    
    // MARK: - Public Functions
    func updateScore(score: Int) {
        self.scoreLabel.text = String(score)
    }
    
    func updateStarsCollected(collected: Int) {
        self.starsCollectedLabel.text = String(collected)
        self.starsCollectedIcon.run(self.animateBounce())
        self.starsCollectedLabel.run(self.animateBounce())
        self.scoreLabel.run(self.animateBounce())
    }
    
    func updateLives(lives: Int) {
        // First clear all sprites
        self.statusBarBackground.enumerateChildNodes( withName: SpriteName.PlayerLives, using: {
            node,  _ in
            if let livesSprite = node as? SKSpriteNode {
                livesSprite.removeFromParent()
            }
        })
        //
        self.statusBarBackground.enumerateChildNodes( withName: SpriteName.LivesLabel, using: {
            node, _ in
            if let livesLabel = node as? SKLabelNode {
                if livesLabel.name == SpriteName.LivesLabel {
                    livesLabel.removeFromParent()
                }
            }
        })
            // Get the X and Y points where we should draw the sprites
        var offsetX = CGFloat()
        let offsetY = self.statusBarBackground.size.height / 2
        
        if lives < 5 {
            for i in 0..<lives {
                let livesSprite = GameTextures.sharedInstance.spriteWithName(name: SpriteName.PlayerLives)
                offsetX = livesSprite.size.width + livesSprite.size.width * 1.5 * CGFloat(i)
                livesSprite.position = CGPoint(x: offsetX, y: offsetY)
                livesSprite.name = SpriteName.PlayerLives
                self.statusBarBackground.addChild(livesSprite)
            }
        } else { // too many lives we need to hide them
            // Lives Icon
            let livesSprite = GameTextures.sharedInstance.spriteWithName(name: SpriteName.PlayerLives)
            livesSprite.position = CGPoint(x: offsetX, y: offsetY)
            livesSprite.name = SpriteName.PlayerLives
            self.statusBarBackground.addChild(livesSprite)
            
            // Lives Lable
            let livesLabel = GameFonts.sharedInstance.createLabel(string: "x"+String(lives), labelType: GameFonts.LabelType.statusBar)
            let offsetX = livesSprite.size.width + livesSprite.size.width * 1.5
            livesLabel.position = CGPoint(x: offsetX, y: offsetY)
            livesLabel.name = SpriteName.LivesLabel
            self.statusBarBackground.addChild(livesLabel)
        }
    }
    
    func animateBounce() -> SKAction {
        let scaleUp = SKAction.scale(to: 1.5, duration: 0.12)
        let scaleNormal = SKAction.scale(to: 1.0, duration: 0.12)
        let scaleSequence = SKAction.sequence([scaleUp, scaleNormal])
        return scaleSequence
    }

}
