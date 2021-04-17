//
//  SnakeHead.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import UIKit
import SpriteKit

class SnakeHead: SnakeBodyPart {
    override init(atPoint: CGPoint, diametr: Int = 10){
        super.init(atPoint: atPoint, diametr: 10)
        settingPhysics()
    }
    
    override func settingPhysics(){
        super.settingPhysics()
        self.physicsBody?.categoryBitMask = CollisionCategory.SnakeHead
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple |  CollisionCategory.Snake
    }
    
    func relocateNewPoint(_ newPoint: CGPoint){
        let moveAction = SKAction.move(to: newPoint, duration: 1.0)
        self.run(moveAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
