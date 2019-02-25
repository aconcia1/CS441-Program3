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
    let rotateRec = UIRotationGestureRecognizer()
    let tapRec = UITapGestureRecognizer()
    var theRotation:CGFloat = 0
    var offset:CGFloat = 0

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }

    override func didMove(to view: SKView) {

        if let someFin:SKSpriteNode = self.childNode(withName: "Finland") as? SKSpriteNode {

            finland = someFin
        }

        rotateRec.addTarget(self,action:#selector(GameScene.rotateView(_:)))

        self.view!.addGestureRecognizer(rotateRec)

        tapRec.addTarget(self, action:#selector(GameScene.tappedView))
        tapRec.numberOfTouchesRequired = 1
        tapRec.numberOfTapsRequired = 1
        self.view!.addGestureRecognizer(tapRec)
    }

    @objc func rotateView(_ sender:UIRotationGestureRecognizer) {

        if(sender.state == .began) {
            
        }
        
        if(sender.state == .changed) {
            
            theRotation = CGFloat(sender.rotation) + self.offset
            theRotation = theRotation * -1
            
            finland.zRotation = theRotation
        }
        
        if(sender.state == .ended) {
            
            self.offset = finland.zRotation * -1
        }
    }

    /*There will be
    death to the red army
    all over the white background
    */

    @objc func tappedView() {
        
        let xVector:CGFloat = sin(theRotation) * -10
        let yVector:CGFloat = cos(theRotation) * 10
        
        let theVector:CGVector = CGVector(dx: xVector, dy: yVector)
        
        finland.physicsBody?.applyImpulse(theVector)
    }
    
    //they will not see this coming
    func touchDown(atPoint pos : CGPoint) {

    }

    func touchMoved(toPoint pos : CGPoint) {

    }

    //'Ere we go
    //You pull the pin then throw the other part
    //Point us at the tanks

    func touchUp(atPoint pos : CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

}
