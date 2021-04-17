//
//  SnakeBodyPart.swift
//  Snake
//
//  Created by Valentin Mironov on 14.04.2021.
//

import UIKit
import SpriteKit

class SnakeBodyPart:  SKShapeNode {
    let diametr: Int
    
    init(atPoint: CGPoint, diametr: Int = 10){
        self.diametr = diametr
        super.init()
        path = UIBezierPath(rect: CGRect(x: -diametr/2, y: -diametr/2, width: diametr, height: diametr)).cgPath
        fillColor = .green
        strokeColor = fillColor
//        lineWidth = CGFloat(diametr)
        self.position = atPoint
        
        settingPhysics()
    }
    
    func settingPhysics(){
        self.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(diametr - 4), center: .zero)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = CollisionCategory.Snake
        self.physicsBody?.contactTestBitMask = CollisionCategory.EdgeBody | CollisionCategory.Apple
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
