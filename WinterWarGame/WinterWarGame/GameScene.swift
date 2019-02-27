//
//  GameScene.swift
//  WinterWarGame
//
//  Created by Anthony Conciatori on 2/20/19.
//  Copyright © 2019 Anthony Conciatori. All rights reserved.
//

import SpriteKit
import GameplayKit

//Here i will show the ineptitude of the Red Army

class GameScene: SKScene {

    var finland:SKSpriteNode = SKSpriteNode()
    var soviet1:SKSpriteNode = SKSpriteNode()
    var soviet2:SKSpriteNode = SKSpriteNode()
    var soviet3:SKSpriteNode = SKSpriteNode()
    let rotateRec = UIRotationGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    var theRotation:CGFloat = 0
    var offset:CGFloat = 0
    let path = UIBezierPath()
    var bulletVar = SKSpriteNode()

    override func update(_ currentTime: TimeInterval) {
        
    }

    override func didMove(to view: SKView) {
        
        if let someSov1:SKSpriteNode = self.childNode(withName: "Soviet1") as? SKSpriteNode {
            
            soviet1 = someSov1
        }
        
        if let someSov2:SKSpriteNode = self.childNode(withName: "Soviet2") as? SKSpriteNode {
            
            soviet2 = someSov2
        }
        
        if let someSov3:SKSpriteNode = self.childNode(withName: "Soviet3") as? SKSpriteNode {
            
            soviet3 = someSov3
        }
        
        if let someFin:SKSpriteNode = self.childNode(withName: "Finland") as? SKSpriteNode {

            finland = someFin
        }
        
        rotateRec.addTarget(self,action:#selector(GameScene.rotateView(_:)))

        self.view!.addGestureRecognizer(rotateRec)

        tapRec.addTarget(self, action:#selector(GameScene.tappedView))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
        
        let finPoint:CGPoint = finland.position
        
        path.move(to: finPoint)
        path.addLine(to: finPoint)
        
        let move = SKAction.follow(path.cgPath, speed: 200.0)
        soviet1.run(move)
        soviet2.run(move)
        soviet3.run(move)
    }

    @objc func rotateView(_ sender:UIRotationGestureRecognizer) {

        if(sender.state == .began) {
            
        }
        
        if(sender.state == .changed) {
            
            theRotation = CGFloat(sender.rotation) + self.offset
            theRotation = theRotation * -1
            
            finland.zRotation = theRotation
            soviet1.zRotation = 0
            soviet2.zRotation = 0
            soviet3.zRotation = 0
        }
        
        if(sender.state == .ended) {
            
            self.offset = finland.zRotation * -1
            soviet1.zRotation = 0
            soviet2.zRotation = 0
            soviet3.zRotation = 0
        }
    }

    @objc func tappedView() {
        
        let xVector:CGFloat = sin(theRotation) * -10
        let yVector:CGFloat = cos(theRotation) * 10
        
        let theVector:CGVector = CGVector(dx: xVector, dy: yVector)
        
        let bulletTexture = SKTexture(imageNamed: "bullet")
        
        bulletVar = SKSpriteNode(texture: bulletTexture)
        
        bulletVar.physicsBody = SKPhysicsBody(texture: bulletTexture, size:bulletVar.size)
        
        bulletVar.position = finland.position
        
        bulletVar.zRotation = finland.zRotation
        
        bulletVar.physicsBody?.applyForce(theVector)
        
        finland.physicsBody?.applyImpulse(theVector)
    }
    
}
