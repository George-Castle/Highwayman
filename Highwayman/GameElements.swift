//
//  GameElements.swift
//  Flappyman
//
//  Created by George Castle on 17/04/2020.
//  Copyright © 2020 George Castle. All rights reserved.
//

import Foundation
import SpriteKit

struct CollisionBitMask {
    static let manCategory:UInt32 = 0x1 << 0
    static let pillarCategory:UInt32 = 0x1 << 1
    static let flowerCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
    static let farmerCategory:UInt32 = 0x1 << 4
}
class Assets {
    static let sharedInstance = Assets()
    //let sprite = SKTextureAtlas(named: "Sprites")
    let hay1 = SKTexture(imageNamed: "hay1")
    let hay2 = SKTexture(imageNamed: "hay2")
    let seeder = SKTexture(imageNamed: "seeder")
    let dog = SKTexture(imageNamed: "dog")
    let horse = SKTexture(imageNamed: "horse")
    let cow = SKTexture(imageNamed: "cow")
    let house = SKTexture(imageNamed: "house")
    let castle = SKTexture(imageNamed: "castle")
    let house1 = SKTexture(imageNamed: "house1")
    let coach = SKTexture(imageNamed: "coach")
    let knight = SKTexture(imageNamed: "knight")
    let chicken = SKTexture(imageNamed: "chicken")
    func preloadAssets() {
        hay1.preload(completionHandler:){
            print("hay1 preloaded")
        }
        hay2.preload(completionHandler:){
            print("hay2 preloaded")
        }
        seeder.preload(completionHandler:){
            print("seeder preloaded")
        }
        dog.preload(completionHandler:){
            print("dog preloaded")
        }
        horse.preload(completionHandler:){
            print("horse preloaded")
        }
        cow.preload(completionHandler:){
            print("cow preloaded")
        }
        house.preload(completionHandler:){
            print("house preloaded")
        }
        castle.preload(completionHandler:){
            print("castle preloaded")
        }
        house1.preload(completionHandler:){
            print("house1 preloaded")
        }
        coach.preload(completionHandler:){
            print("coach preloaded")
        }
        chicken.preload(completionHandler:){
            print("chicken preloaded")
        }
        knight.preload(completionHandler:){
            print("knight preloaded")
        }
    }
}

extension GameScene{
    //create the man in the scene
    func createman() -> SKSpriteNode {
    //1
    let man = SKSpriteNode(texture: SKTextureAtlas(named:"player").textureNamed("man1"))
        //man size
    man.size = CGSize(width: 55, height: 55)
    man.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 50)
    //2
    man.physicsBody = SKPhysicsBody(circleOfRadius: man.size.width / 2)
    man.physicsBody?.linearDamping = 1.0
    man.physicsBody?.restitution = 0.0
    //3
    man.physicsBody?.categoryBitMask = CollisionBitMask.manCategory
    man.physicsBody?.collisionBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.groundCategory | CollisionBitMask.farmerCategory
    man.physicsBody?.contactTestBitMask = CollisionBitMask.pillarCategory | CollisionBitMask.flowerCategory | CollisionBitMask.groundCategory | CollisionBitMask.farmerCategory
    //4
    man.physicsBody?.affectedByGravity = false
    man.physicsBody?.isDynamic = true
    man.physicsBody?.allowsRotation = false

    
    return man
    }
    
    
    func createFarmer() -> SKSpriteNode {
    //1
    let farmer = SKSpriteNode(texture: SKTextureAtlas(named:"farmer").textureNamed("farmer1"))
        //man size
    farmer.size = CGSize(width: 55, height: 55)
    farmer.position = CGPoint(x:self.frame.midX - 160, y:self.frame.midY - 50)
    //2
    farmer.physicsBody = SKPhysicsBody(circleOfRadius: farmer.size.width / 2)
    farmer.physicsBody?.linearDamping = 0.2
    farmer.physicsBody?.restitution = 0
    //3
    farmer.physicsBody?.categoryBitMask = CollisionBitMask.farmerCategory
    farmer.physicsBody?.collisionBitMask = CollisionBitMask.manCategory
    farmer.physicsBody?.contactTestBitMask = CollisionBitMask.manCategory
    //4
    farmer.physicsBody?.affectedByGravity = false
    farmer.physicsBody?.isDynamic = true

    
    return farmer
    }
    
    //1
    func createRestartBtn() {
        restartBtn = SKSpriteNode(imageNamed: "menu")
        restartBtn.size = CGSize(width:200, height:40)
        restartBtn.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 2) - 90)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        self.addChild(restartBtn)
        restartBtn.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //2
    func createPauseBtn() {
        pauseBtn = SKSpriteNode(imageNamed: "pause")
        pauseBtn.size = CGSize(width:40, height:40)
        pauseBtn.position = CGPoint(x: self.frame.width - 30, y: 30)
        pauseBtn.zPosition = 6
        self.addChild(pauseBtn)
    }
    //3
    func createScoreLabel() -> SKLabelNode {
    let scoreLbl = SKLabelNode()
    scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.6)
    scoreLbl.text = "\(score)"
    scoreLbl.zPosition = 5
    scoreLbl.fontSize = 50
    scoreLbl.fontName = "Baskerville-Italic"
    
    let scoreBg = SKShapeNode()
    scoreBg.position = CGPoint(x: 0, y: 0)
    scoreBg.path = CGPath(roundedRect: CGRect(x: CGFloat(-50), y: CGFloat(-30), width: CGFloat(100), height: CGFloat(100)), cornerWidth: 50, cornerHeight: 50, transform: nil)
    let scoreBgColor = UIColor(red: CGFloat(0.0 / 255.0), green: CGFloat(0.0 / 255.0), blue: CGFloat(0.0 / 255.0), alpha: CGFloat(0.2))
    scoreBg.strokeColor = UIColor.clear
    scoreBg.fillColor = scoreBgColor
    scoreBg.zPosition = -1
    scoreLbl.addChild(scoreBg)
    return scoreLbl
    }
    //4
    func createHighscoreLabel() -> SKLabelNode {
    let highscoreLbl = SKLabelNode()
    highscoreLbl.position = CGPoint(x: self.frame.width - 80, y: self.frame.height - 62)
    if let highestScore = UserDefaults.standard.object(forKey: "highestScore"){
    highscoreLbl.text = "Highest Score: \(highestScore)"
    } else {
    highscoreLbl.text = "Highest Score: 0"
    }
    highscoreLbl.zPosition = 5
    highscoreLbl.fontSize = 16
    highscoreLbl.fontName = "Baskerville-Italic"
    return highscoreLbl
    }
    func createCongrats(){
    let congratsscoreLbl = SKLabelNode()
    congratsscoreLbl.position = CGPoint(x: self.frame.width / 2, y:(self.frame.height / 2) + 60)
    congratsscoreLbl.text = "New Highest Score!"
    congratsscoreLbl.zPosition = 5
    congratsscoreLbl.fontSize = 36
    congratsscoreLbl.fontName = "Baskerville-Italic"
    self.addChild(congratsscoreLbl)
    }
    func createEndScoreLabel() -> SKLabelNode {
    let endscoreLbl = SKLabelNode()
    endscoreLbl.numberOfLines = 0
    endscoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        


    endscoreLbl.text = "You Scored: \(score)"
    endscoreLbl.zPosition = 5
    endscoreLbl.fontSize = 36
    endscoreLbl.fontName = "Baskerville-Italic"
    return endscoreLbl
    }
    //5
    func createLogo() {
        logoImg = SKSpriteNode()
        logoImg = SKSpriteNode(imageNamed: "logo")
        logoImg.size = CGSize(width: 272, height: 65)
        logoImg.position = CGPoint(x:self.frame.midX, y:self.frame.midY + 100)
        logoImg.setScale(0.5)
        self.addChild(logoImg)
        logoImg.run(SKAction.scale(to: 1.0, duration: 0.3))
    }
    //6
    func createTaptoplayLabel() -> SKLabelNode {
        let taptoplayLbl = SKLabelNode()
        taptoplayLbl.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 110)
        taptoplayLbl.text = "Tap to steal chickens"
        taptoplayLbl.fontColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
        taptoplayLbl.zPosition = 5
        taptoplayLbl.fontSize = 20
        taptoplayLbl.fontName = "Baskerville-BoldItalic"
        return taptoplayLbl
    }
    func createLeaderboardBtn() {
        leaderboardBtn = SKSpriteNode(imageNamed: "leaderboard1")
        leaderboardBtn.size = CGSize(width:200, height:40)
        leaderboardBtn.position = CGPoint(x:self.frame.midX, y:self.frame.midY - 160)
        leaderboardBtn.zPosition = 5
        self.addChild(leaderboardBtn)
    }
    
    func createWalls() -> SKNode  {
    // 1
    // creates pillars
    let chicken = Assets.sharedInstance.chicken
    let flowerNode = SKSpriteNode(texture: chicken)
    flowerNode.size = CGSize(width: 30, height: 30)
    flowerNode.position = CGPoint(x: self.frame.width + 25, y: 220 + CGFloat.random(in:1...25))
    flowerNode.physicsBody = SKPhysicsBody(rectangleOf: flowerNode.size)
    flowerNode.physicsBody?.affectedByGravity = false
    flowerNode.physicsBody?.isDynamic = false
    flowerNode.physicsBody?.categoryBitMask = CollisionBitMask.flowerCategory
    flowerNode.physicsBody?.collisionBitMask = 0
    flowerNode.physicsBody?.contactTestBitMask = CollisionBitMask.manCategory
    flowerNode.color = SKColor.blue
    // 2
    //flowers
    wallPair = SKNode()
    wallPair.name = "wallPair"
       
        let obstacles = [(Assets.sharedInstance.hay1, 0.07), (Assets.sharedInstance.hay2, 0.21), (Assets.sharedInstance.seeder, 0.36), (Assets.sharedInstance.dog, 0.075), (Assets.sharedInstance.horse, 0.15), (Assets.sharedInstance.cow, 0.32)]
        let obstacles2 = [(Assets.sharedInstance.hay1, 0.07), (Assets.sharedInstance.hay2, 0.21), (Assets.sharedInstance.house, 0.31)]
        let obstacles3 = [(Assets.sharedInstance.knight, 0.15), (Assets.sharedInstance.horse, 0.21), (Assets.sharedInstance.castle, 0.35)]
        let obstacles4 = [(Assets.sharedInstance.dog, 0.07), (Assets.sharedInstance.coach, 0.19), (Assets.sharedInstance.house1, 0.4)]
        
        var Wall = obstacles[0].0
        var Size = obstacles[0].1
        if score > 1 && score < 20{
            let randomObstacle = Int.random(in:0...2)
            Wall = obstacles[randomObstacle].0
            Size = obstacles[randomObstacle].1
            
        } else if score >= 20 && score < 40{
            let randomObstacle = Int.random(in:3...5)
            Wall = obstacles[randomObstacle].0
            Size = obstacles[randomObstacle].1
        } else if score >= 40 && score < 60{
            let random = Int.random(in:0...2)
            Wall = obstacles2[random].0
            Size = obstacles2[random].1
        }else if score >= 60 && score < 80{
            let random = Int.random(in:0...2)
            Wall = obstacles4[random].0
            Size = obstacles4[random].1
        }else if score >= 80 {
            let random = Int.random(in:0...2)
            Wall = obstacles3[random].0
            Size = obstacles3[random].1
        } 
        let btmWall = SKSpriteNode(texture: Wall)
        //let btmWall = SKSpriteNode(imageNamed: Obstacle)

    //topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 420)
    btmWall.position = CGPoint(x: self.frame.width + 25, y: 150)
    
    //topWall.setScale(0.5)
    btmWall.setScale(CGFloat(Size))
    
    //topWall.physicsBody = SKPhysicsBody(rectangleOf: topWall.size)
    //topWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
    //topWall.physicsBody?.collisionBitMask = CollisionBitMask.manCategory
    //topWall.physicsBody?.contactTestBitMask = CollisionBitMask.manCategory
    //topWall.physicsBody?.isDynamic = false
    //topWall.physicsBody?.affectedByGravity = false
        

    
    btmWall.physicsBody = SKPhysicsBody(rectangleOf: btmWall.size)
    btmWall.physicsBody?.categoryBitMask = CollisionBitMask.pillarCategory
    btmWall.physicsBody?.collisionBitMask = CollisionBitMask.manCategory
    btmWall.physicsBody?.contactTestBitMask = CollisionBitMask.manCategory
    btmWall.physicsBody?.isDynamic = false
    btmWall.physicsBody?.affectedByGravity = false
    
    //topWall.zRotation = CGFloat.pi    //rotating pillar image
    
    //wallPair.addChild(topWall)
    wallPair.addChild(btmWall)
    
    wallPair.zPosition = 1
    // 3
    //let randomPosition = random(min: -50, max: 200)
    wallPair.position.y = 180
    wallPair.addChild(flowerNode)
    
    wallPair.run(moveAndRemove)
    
    return wallPair
    }
    func random() -> CGFloat{
        return CGFloat(Float(arc4random()) / 4294967296.0)
    }
    func random(min : CGFloat, max : CGFloat) -> CGFloat{
    return random() * (max - min) + min
    }
}
